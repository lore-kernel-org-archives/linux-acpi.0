From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI HOWTO
Date: 21 May 2004 00:39:16 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1085114355.12354.586.camel@dhcppc4>
References: <B774920D825C2D4880A3C1B0D6EF94189A5063@ssdmx.ssd.fsi.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <B774920D825C2D4880A3C1B0D6EF94189A5063-YbQoUGCEyAW+LrQOllSzDQC/G2K4zDHf@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Rockefeller, Harry" <harryr-UjZhlPPWhclBDgjK7y7TUQ@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-05-18 at 10:50, Rockefeller, Harry wrote:
> Several tech HowTos are maturing via direct input from users using
> a wiki of some sort.  The ones I have used and seen however
> suffer from poor organization.
> 
> I would suggest readers of this group pound out some kind of
> a framework (outline?) that someone could host on a wiki where
> everyone/anyone can ask questions and provide answers.
> 
> So, here is my attempt at getting it started:
> 
> [Note:  This may not be the best solution.  Perhaps most of this
> information is already available or has been answered in this
> list.  Because ACPI is so tied to kernel drivers and is changing
> at an enourmous rate the "structure" of a HOWTO may not be the
> most effective use of developer's time.  It won't hurt me if my
> idea is torn to shreds or worse (better?) a one line link that
> says look here for 95% of the answers to these questions.]
> 
> What is ACPI?  Maybe terse definition is all that is needed with
>    pointers to Intel standard, and some others.
> 
> If ACPI is an Intel standard does it work with Athlon or other
>    hardware?

Intel is just one of the spec authors/promoters.
Yes, ACPI works also on systems w/o Intel processors, such as Intel
compatible processors from AMD.

> Where does ACPI fit in ...
>    Replacement for APM
>    A) the boot process of ...
>         A1) any PC?
>              What is happening (is ACPI or APM involved) before
>              the BIOS interrupt screen happens?
>              What is happening between the BIOS and the Linux
>              Loader (LILO or Grub, etc.)  i.e., can a multi-kernel
>              system allow booting either APM or ACPI? 

The kernel (eg distro kernel) is generally built with both APM and ACPI.
If ACPI is found, APM is disabled.  The BIOS can have any combination of
APM or ACPI support, and the kernel should still work.

ACPI also replaces PnP, PIRQ, and MPS specs. for configuration.

>         A2) battery powered PC?
>              What controls battery charge when nothing else is
>              running?

Battery charging is controlled by hardware.

>              What is going on when I hit the power button and
>              lights flash but then nothing?  [A lo-o-ong power
>              button press causes a normal boot.]
>    B) standby = S2?
>         I think it went into S2 ok, but I can't wake it up?

S2 is deprecated.  Indeed, I've never seen a platform that supports it.

S1 is supported, but worthless as it doesn't save hardly any power.

>    C) Suspend to RAM = S3?
>         I think it went into S3 ok, but I can't wake it up?

bugs;-)

>    D) Suspend to DISK = S4?
>         D1) Are there any alternatives to APM and ACPI?
>              provide link to swsusp(2)?
>    E) Emergency shutdown = S5?

S5 is "soft off", and may have nothing to do with an emergency.

> 
> I think I have found an acpi bug.  How do I report it?
> What logs, kernel debug parameters to enhance logs, etc.
> are important to the acpi developers?

this is on http://acpi.sourceforge.net which is listed as the home page
for Linux/ACPI in /usr/src/MAINTAINERS.

cheers,
-Len




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
