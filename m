From: Alan Jenkins <sourcejedi.lkml-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: 1005PE's and backlight controls
Date: Wed, 14 Apr 2010 17:23:22 +0100
Message-ID: <t2i9b2b86521004140923x9c1aaa64p867674329ae158af@mail.gmail.com>
References: <y2g3b2dfeb01004131934x67e23d80vc73dfd6d5af133fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <y2g3b2dfeb01004131934x67e23d80vc73dfd6d5af133fa-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Chris Bagwell <chris-ZCD0YumhXB+iMFqZbmIluw@public.gmane.org>
Cc: ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 4/14/10, Chris Bagwell <chris-ZCD0YumhXB+iMFqZbmIluw@public.gmane.org> wrote:
> Hi all,
>
> I've seen the following issue reported on various web pages but not sure if
> it was directly reported.  First up, you guys know about issue with acpi_osi
> of "Windows 2009" disables eeepc_backend and thats were eeepc_wmi comes in.

[Subsequent messages from Chris clarified that both eeepc-laptop and
eeepc-wmi suffer as described below]

> There is a secondary bug though if you boot with acpi_osi="!Windows 2009"
> (or "Linux").  The ACPI driver will take control of backlight controls with
> Fn-F5/F6.  Those keys will work but has issues with Gnome and other user
> processes.
>
> Anything that uses any of the /sys/* interfaces to control backlight do not
> work correctly.  When software cycles threw levels, the behavior is kinda
> odd.  It will cycle each time you dim to something like
> Bright->Dim->Bight->Off->Bright->etc.  Also, Gnome will give no feedback
> because eeepc_laptop discards the events and it will not make it to
> /dev/input/event*.  And last, the status of current brightness is never
> updated under /sys/* correctly which confuses Gnome as well.
>
> The secondary work around is to add acpi_backlight=vendor to boot options.
> Then eepc_backlight takes charge and life is good.  Gnome gives visual
> feedback and dimmer works as expected.
>
> Baring a firmware fix from Asus, would it be possible to enable some sort of
> backlist for using ACPI backlight support and have 1005P's use eeepc_laptop?
>
> Chris

I suggest you contact the ACPI video maintainer, Zhang Rui
<rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, and attach the output of "dmidecode".  The best
way would probably be to report the problem on bugzilla.kernel.org (on
the ACPI video driver).

I think it will indeed be possible to blacklist your machine, because
someone has already anticipated this problem :-).


drivers/acpi/video_detect.c:

long acpi_video_get_capabilities(acpi_handle graphics_handle)
...
		/* Add blacklists here. Be careful to use the right *DMI* bits
		 * to still be able to override logic via boot params, e.g.:
		 *
		 *   if (dmi_name_in_vendors("XY")) {
...
		 *	acpi_video_support |=
		 *		ACPI_VIDEO_BACKLIGHT_DMI_VENDOR;
		 *}
		 */

Regards
Alan

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
