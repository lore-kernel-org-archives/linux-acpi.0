From: ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org (Eric W. Biederman)
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Date: Tue, 20 Sep 2005 20:08:07 -0600
Message-ID: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B30047B8DAF@hdsmsx401.amr.corp.intel.com>
	<m1d5ngk4xa.fsf@ebiederm.dsl.xmission.com>
	<Pine.SOC.4.61.0509111140550.9218@math.ut.ee>
	<m14q8fhc02.fsf_-_@ebiederm.dsl.xmission.com>
	<m1zmq7fx3v.fsf_-_@ebiederm.dsl.xmission.com>
	<20050920210617.GA1779@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050920210617.GA1779-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org> (Pavel Machek's message of
 "Tue, 20 Sep 2005 23:06:17 +0200")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Pierre Ossman <drzeus-list-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, Masoud Sharbiani <masouds-VSK0CvVmMoVQFI55V6+gNQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> writes:

> Hi!
>
>> In the lead up to 2.6.13 I fixed a large number of reboot
>> problems by making the calling conventions consistent.  Despite
>> checking and double checking my work it appears I missed an
>> obvious one.
>> 
>> The S4 suspend code for PM_DISK_PLATFORM was also calling
>> device_shutdown without setting system_state, and was
>> not calling the appropriate reboot_notifier.
>
> ACK on both. But should not you submit patch via -mm, so it gets at
> least some testing there?

The code is obviously correct, and the people with the problem
have reported that this approach solves it.

If this bit of functionality is to even work we need to do
something like this.

So I don't see what benefit putting this in -mm would give.  If
I was aggressive I would say that this needs to be in 2.6.13.N.
If I'm not following some procedure I don't have a problem
changing though.

This is the final fix I know of to get a consistent set of semantics
for the everything in the ``reboot path''.

>From a practical standpoint I am very tardy in getting this out.

Eric


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
