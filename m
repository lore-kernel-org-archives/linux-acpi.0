From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Mon, 29 Jul 2002 20:31:44 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020729183143.GA13729@elf.ucw.cz>
References: <20020729175650.GA1233@elf.ucw.cz> <20020729173302.30557@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020729173302.30557-Q0ErXNX1RuY/GWcAdfcqrQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>, Lyle <lwspm-RAHWjsxJnJUdnm+yROfE0A@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >Discussing with who?
> 
> We had a Power Management BOF there, among others, Patrick Mochel,
> Greg KH, Andy, Paulus, Jeff Garzik, ...

Oops... I guess I should have been there :-(. Sorry.

> >Its rather simple: free half of memory, stop everything, save device
> >state, copy used memory into free memory, continue devices, save data
> >from "free" memory into swap.
> 
> Ok, so you first push as much as you can to swap to free half
> of memory. Then, when you say you copy used memory, I assume you copy
> all of RAM including kernel memory (kernel data structures etc...)
> right ?

Yes.

> What do you mean by "stop everything" ? Stop user processes ? Kernel
> threads ? both ? 

Stop all user processes and all kernel processes that could cause
trouble. Don't stop kapm-idled (for example) but be sure to stop
ext3-commitd (or how is that beast called).

> Then, you only save device state (and then suspend
> devices) after you have "stopped everything" ?

Yes.

Code looks like this:

void do_software_suspend(void)
{
        arch_prepare_suspend();
        if (prepare_suspend_console())
                printk( "%sCan't allocate a console... proceeding\n", name_suspend);
        if (!prepare_suspend_processes()) {

                /* At this point, all user processes and "dangerous"
                   kernel threads are stopped. Free some memory, as we
                   need half of memory free. */

                free_some_memory();

                /* No need to invalidate any vfsmnt list -- they will be valid after resume, anyway.
                 *
                 * We sync here -- so you have consistent filesystem state when things go wrong.
                 * -- so that noone writes to disk after we do atomic copy of data.
                 */
                PRINTK("Syncing disks before copy\n");
                do_suspend_sync();

                /* Save state of all device drivers, and stop them. */
                if(drivers_suspend()==0)
                        /* If stopping device drivers worked, we proceed basically into
                         * suspend_save_image.
                         *
                         * do_magic(0) returns after system is resumed.
                         *
                         * do_magic() copies all "used" memory to "free" memory, then
                         * unsuspends all device drivers, and writes memory to disk
                         * using normal kernel mechanism.
                         */
                        do_magic(0);
                PRINTK("Restarting processes...\n");
                thaw_processes();
        }
        software_suspend_enabled = 1;
        MDELAY(1000);
        restore_console ();
}

(Most comments were added 5 minutes ago).

Does it look understendable now?
									Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
