From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: down_timeout
Date: Fri, 3 Oct 2003 13:36:32 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031003133632.4b8cd1bc.akpm@osdl.org>
References: <3F7D6DA1.9070801@namesys.com>
	<20031003142518.GN24824@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031003142518.GN24824-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: umka-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org> wrote:
>
> /* Returns -EINTR if the timeout expires */
> int down_timeout(struct semaphore *sem, long timeout)
> {
> 	struct timer_list timer;
> 	int result;
> 
> 	init_timer(&timer);
> 	timer.expires = timeout + jiffies;
> 	timer.data = (unsigned long) current;
> 	timer.function = process_timeout;
> 
> 	add_timer(&timer);
> 	result = down_interruptible(sem);
> 	del_timer_sync(&timer);
> 
> 	return result;
> }

down_interruptible() will only break out if signal_pending(current), so the
wakeup-on-expiry here will not work as desired.

New per-arch primitives would be needed to implement this, I think.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
