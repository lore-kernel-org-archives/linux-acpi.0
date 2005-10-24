From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: sony vaio pcg-k45 hell
Date: Mon, 24 Oct 2005 12:22:31 +0200
Message-ID: <20051024102231.GA32705@message-id.gmane0305.slipkontur.de>
References: <3ACA40606221794F80A5670F0AF15F84041AC212@pdsmsx403> <64b848100510231807u36cd8056q521204eaa9099ebc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <64b848100510231807u36cd8056q521204eaa9099ebc-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Just to recall my experience with a vaio vgn-fs115b running
SUSE 10.0:

On Sun, Oct 23, 2005 at 07:07:08PM -0600, Thom Cherryhomes wrote:
> well, to start:
> 
> (1) battery meter most of the time shows zero

worked

> (2) I get maybe 1 hour battery time.

cpufreq active? This has not much to do with ACPI, though.

> (3) S3 suspend does NOT work at all (using hibernate-ram script)

Probably not a general ACPI problem. Read Documentation/power/video.txt

> (4) i get unusual time readings that seem to keep incrementing when
> the battery is charging (when I DO see the battery meter)
> (5) no fan control

sony crap bios, no ACPI fan control methods => not an ACPI problem

> (6) display does not dim when disconnected.

you need Stelian Pop's sony_acpi module for that (and a mechanism to adjust
the brightness on ac adapter plug/unplug, powersaved does this on SUSE).
It might also work with the generic_hotkey module, but i could not figure
out how to do it (i remember posts on acpi-devel that claimed that all
vendor specific acpi drivers are obsoleted by generic_hotkey, still have
to find out how to control the brightness of my panasonic with it).

> (7) hotkeys for changing brightness etc do not work.

SONY crap. These are no ACPI hotkeys, all the hotkeys on the vgn-fs115
emitted a standard keycode. Unfortunately all emitted the same keycode.

> arrggghhhhh

SONY notebooks are just badly designed IMO, even the Windows XP drivers
and utilities looked and felt very hackish.
Although the hardware / case / display / keyboard were fine, i would
probably not buy a SONY if i had to pay it with my own money.
 
> I tried to find a PSS table in the DSDT, and couldn't.. it seems the
> acpi on this laptop is insanely broken. :-(

Most of the problems you have are probably not ACPI problems.
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
