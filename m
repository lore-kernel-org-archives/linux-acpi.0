From: Alberto Piai <albeclemit-whZMOeQn8C0@public.gmane.org>
Subject: Re: Re: S3 resume on Fujitsu-Siemens Amilo A7620 (CONTINUES)
Date: Thu, 28 Oct 2004 00:44:24 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041028004424.1b0f95fb.albeclemit@yahoo.it>
References: <20041018134238.4cf1b380.albeclemit@yahoo.it>
	<20041018124756.GA28463@elf.ucw.cz>
	<20041018225412.397dcd1f.albeclemit@yahoo.it>
	<20041018212208.GA10490@elf.ucw.cz>
	<20041019002115.2faa9436.albeclemit@yahoo.it>
	<20041018230008.GC10490@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041018230008.GC10490-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: pavel-AlSwsSmVLrQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 19 Oct 2004 01:00:08 +0200
Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org> wrote:

> Hi!
> 
> > > > So now it's going out of wakeup.S, right?

> > > > We should be in drivers/acpi/sleep/main.c at that point
> > > 
> > > Yes. I assume that video does not work for you? Do you see at least
> > > blinking cursor?
> > > 

> We can't call video bios from protected mode, sorry. If machine comes
> up with all devices working (try capslock) but video, you should be
> able to reinitialize video using emu from X11 or some other hack.

Update:
2.6.9, with pushl and popl lines commented out:
the machine survives wakeup.S, then hangs with the hard disk light on. CapsLock is working, but Ctrl+Alt+Del doesn't reboot (if i keep it pressed for some seconds it generates a beep.)

I still didn't find a way to debug it, please help me! At which point should we be if harddisk was (kind of) turned on?

Thanks,
Alberto


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
