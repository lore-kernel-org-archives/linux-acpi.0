From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: can't get standby (S1) to work
Date: Sun, 21 Dec 2003 03:54:27 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031221015427.GC3587@luna.mooo.com>
References: <200312201644.hBKGiX228156@webmail2.cac.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200312201644.hBKGiX228156-vziUDZACzaCQ8O33ekXIjvZ8FUJU4vz8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Dec 20, 2003 at 11:44:33AM -0500, Nirmal Govind wrote:
> Hi.. I have acpi compiled into the kernel and also have swsusp. Now, when I try
> echo 1 > /proc/acpi/sleep, nothing happens. I'm running Mandrake 9.2, 2.4.22-21
> kernel that I compiled with (almost?) all the acpi options enabled. The laptop
> is a Fujitsu Lifebook S6120D. Is there any way to get the laptop to standby? I
> move around a lot with this computer and really would like to get the standby
> working. The swsusp seems to work with the suspend to disk, i.e. when I do an
> echo 1 > /proc/swsusp/activate .. however, after the computer suspended, I
> couldn't bring it back up - when I hit the power button, it tried to resume,
> did something, and then gave me a blank screen -- had to do a hard reboot after
> that.
> 

swsusp doesn't give you S1 and S3, only S4. For S1 and S3 you'll need
2.6 or apm and a dedicated partition (if your bios supports it).
If its swsusp from mandrake then you should get the latest swsusp
patches and try with those (don't know what version the mandrake kernel
has). You'll probably need to get a vanilla kernel for that (mandrakes
is heavily patched afaik). I would also suggest upgrading to 2.4.23 as
2.4.22 has a security bug.
Do you have a resume=<swap partition> in your lilo/grub/whatever config?
Are there any messages in /var/log/syslog saying what happened after
wakeup? Do you even see the beginning of the resume process? (you
should see the kernel starting up). Are you using the suspend script?
whats the output of /proc/swsusp/debug_info or /proc/swsusp/version (if
they don't exist then its a really old version).
Also try on the swsusp-devel list (look at swsusp.sf.net), there is
lots more of good help there then you would be able to find here as
this is not an acpi issue.

> Thanks,
> nirmal
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
