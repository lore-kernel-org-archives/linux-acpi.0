From: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: down_timeout
Date: Fri, 3 Oct 2003 15:25:18 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031003142518.GN24824@parcelfarce.linux.theplanet.co.uk>
References: <3F7D6DA1.9070801@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3F7D6DA1.9070801-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Yury Umanets <umka-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


[l-k people, skip to the bottom, that's where down_timeout is]

On Fri, Oct 03, 2003 at 04:37:53PM +0400, Yury Umanets wrote:
> Thus, @quantum_ms will be calculated longer for shorter HZ and this is 
> definitelly not good in my opinion. Am I right?

You're right, but for the wrong reason.  This code is pretty inaccurate
as it's relying on the result of integer divides.  This code should
work better (disclaimer: compiled, not tested):

Index: drivers/acpi/osl.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/acpi/osl.c,v
retrieving revision 1.3
diff -u -p -r1.3 osl.c
--- drivers/acpi/osl.c	23 Aug 2003 02:46:37 -0000	1.3
+++ drivers/acpi/osl.c	3 Oct 2003 14:02:44 -0000
@@ -827,7 +827,6 @@ acpi_os_wait_semaphore(
 {
 	acpi_status		status = AE_OK;
 	struct semaphore	*sem = (struct semaphore*)handle;
-	int			ret = 0;
 
 	ACPI_FUNCTION_TRACE ("os_wait_semaphore");
 
@@ -842,56 +841,28 @@ acpi_os_wait_semaphore(
 	if (in_atomic())
 		timeout = 0;
 
-	switch (timeout)
-	{
-		/*
-		 * No Wait:
-		 * --------
-		 * A zero timeout value indicates that we shouldn't wait - just
-		 * acquire the semaphore if available otherwise return AE_TIME
-		 * (a.k.a. 'would block').
-		 */
-		case 0:
-		if(down_trylock(sem))
-			status = AE_TIME;
-		break;
-
-		/*
-		 * Wait Indefinitely:
-		 * ------------------
-		 */
-		case ACPI_WAIT_FOREVER:
+	if (timeout == ACPI_WAIT_FOREVER) {
 		down(sem);
-		break;
-
-		/*
-		 * Wait w/ Timeout:
-		 * ----------------
-		 */
-		default:
-		// TODO: A better timeout algorithm?
-		{
-			int i = 0;
-			static const int quantum_ms = 1000/HZ;
-
+	} else if (down_trylock(sem) == 0) {
+		/* Success, do nothing */
+	} else {
+		long now = jiffies;
+		int ret = 1;
+		while (jiffies < now + timeout * HZ) {
+			current->state = TASK_INTERRUPTIBLE;
+			schedule_timeout(1);
 			ret = down_trylock(sem);
-			for (i = timeout; (i > 0 && ret < 0); i -= quantum_ms) {
-				current->state = TASK_INTERRUPTIBLE;
-				schedule_timeout(1);
-				ret = down_trylock(sem);
-			}
-	
-			if (ret != 0)
-				status = AE_TIME;
+			if (!ret)
+				break;
 		}
-		break;
+		if (ret)
+			status = AE_TIME;
 	}
 
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "Failed to acquire semaphore[%p|%d|%d], %s\n", 
 			handle, units, timeout, acpi_format_exception(status)));
-	}
-	else {
+	} else {
 		ACPI_DEBUG_PRINT ((ACPI_DB_MUTEX, "Acquired semaphore[%p|%d|%d]\n", handle, units, timeout));
 	}
 

[l-k people, this is the interesting bit]

It's still not great because it doesn't preserve ordering.  down_timeout()
would be a much better primitive.  We have down_interruptible() which
could be used for this purpose.  Something like (completely uncompiled):

/* Returns -EINTR if the timeout expires */
int down_timeout(struct semaphore *sem, long timeout)
{
	struct timer_list timer;
	int result;

	init_timer(&timer);
	timer.expires = timeout + jiffies;
	timer.data = (unsigned long) current;
	timer.function = process_timeout;

	add_timer(&timer);
	result = down_interruptible(sem);
	del_timer_sync(&timer);

	return result;
}

(This would have to go in kernel/timer.c as that's where process_timeout
lives).

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
