From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: down_timeout
Date: Fri, 3 Oct 2003 13:29:03 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <D3A3AA459175A44CB5326F26DA7A189C1C3DD3@orsmsx405.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Yury Umanets <umka-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


I would say that the whole thing is wrong -- the kernel should provide a
semaphore wait function that includes a timeout parameter.

Bob


-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Matthew
Wilcox
Sent: Friday, October 03, 2003 7:25 AM
To: Yury Umanets
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; linux-kernel@vger.kernel.org
Subject: [ACPI] down_timeout


[l-k people, skip to the bottom, that's where down_timeout is]

On Fri, Oct 03, 2003 at 04:37:53PM +0400, Yury Umanets wrote:
> Thus, @quantum_ms will be calculated longer for shorter HZ and this is

> definitelly not good in my opinion. Am I right?

You're right, but for the wrong reason.  This code is pretty inaccurate
as it's relying on the result of integer divides.  This code should
work better (disclaimer: compiled, not tested):

Index: drivers/acpi/osl.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /var/cvs/linux-2.6/drivers/acpi/osl.c,v
retrieving revision 1.3
diff -u -p -r1.3 osl.c
--- drivers/acpi/osl.c	23 Aug 2003 02:46:37 -0000	1.3
+++ drivers/acpi/osl.c	3 Oct 2003 14:02:44 -0000
@@ -827,7 +827,6 @@ acpi_os_wait_semaphore(
 {
 	acpi_status		status =3D AE_OK;
 	struct semaphore	*sem =3D (struct semaphore*)handle;
-	int			ret =3D 0;
=20
 	ACPI_FUNCTION_TRACE ("os_wait_semaphore");
=20
@@ -842,56 +841,28 @@ acpi_os_wait_semaphore(
 	if (in_atomic())
 		timeout =3D 0;
=20
-	switch (timeout)
-	{
-		/*
-		 * No Wait:
-		 * --------
-		 * A zero timeout value indicates that we shouldn't wait
- just
-		 * acquire the semaphore if available otherwise return
AE_TIME
-		 * (a.k.a. 'would block').
-		 */
-		case 0:
-		if(down_trylock(sem))
-			status =3D AE_TIME;
-		break;
-
-		/*
-		 * Wait Indefinitely:
-		 * ------------------
-		 */
-		case ACPI_WAIT_FOREVER:
+	if (timeout =3D=3D ACPI_WAIT_FOREVER) {
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
-			int i =3D 0;
-			static const int quantum_ms =3D 1000/HZ;
-
+	} else if (down_trylock(sem) =3D=3D 0) {
+		/* Success, do nothing */
+	} else {
+		long now =3D jiffies;
+		int ret =3D 1;
+		while (jiffies < now + timeout * HZ) {
+			current->state =3D TASK_INTERRUPTIBLE;
+			schedule_timeout(1);
 			ret =3D down_trylock(sem);
-			for (i =3D timeout; (i > 0 && ret < 0); i -=3D
quantum_ms) {
-				current->state =3D TASK_INTERRUPTIBLE;
-				schedule_timeout(1);
-				ret =3D down_trylock(sem);
-			}
-=09
-			if (ret !=3D 0)
-				status =3D AE_TIME;
+			if (!ret)
+				break;
 		}
-		break;
+		if (ret)
+			status =3D AE_TIME;
 	}
=20
 	if (ACPI_FAILURE(status)) {
 		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "Failed to acquire
semaphore[%p|%d|%d], %s\n",=20
 			handle, units, timeout,
acpi_format_exception(status)));
-	}
-	else {
+	} else {
 		ACPI_DEBUG_PRINT ((ACPI_DB_MUTEX, "Acquired
semaphore[%p|%d|%d]\n", handle, units, timeout));
 	}
=20

[l-k people, this is the interesting bit]

It's still not great because it doesn't preserve ordering.
down_timeout()
would be a much better primitive.  We have down_interruptible() which
could be used for this purpose.  Something like (completely uncompiled):

/* Returns -EINTR if the timeout expires */
int down_timeout(struct semaphore *sem, long timeout)
{
	struct timer_list timer;
	int result;

	init_timer(&timer);
	timer.expires =3D timeout + jiffies;
	timer.data =3D (unsigned long) current;
	timer.function =3D process_timeout;

	add_timer(&timer);
	result =3D down_interruptible(sem);
	del_timer_sync(&timer);

	return result;
}

(This would have to go in kernel/timer.c as that's where process_timeout
lives).

--=20
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead
bodies.
Do you think I want to have an academic debate on this subject?" --
Robert Fisk


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
