From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: HP Pavilion zt3240ea and thermal zone
Date: Wed, 13 Oct 2004 14:30:29 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041013123029.GD23992@poupinou.org>
References: <416BAB60.7050809@estg.ipleiria.pt> <416BDF74.8070605@mega.ist.utl.pt> <416C0E80.4050107@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <416C0E80.4050107-Y6VGUYTwhu0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, =?iso-8859-1?Q?Lu=EDs?= Neves <lneves-3+EeCmRbAIqyvGiigdSjEg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 12, 2004 at 10:04:00AM -0700, Nate Lawson wrote:
> Pedro Venda wrote:
> >| Is it normal that this kind of machine (a 1.6GHz centrino) do not have a
> >| thermal zone? I don't find thermal information under XP also but in my
> >| ignorance I thought this should exist.
> >|
> >| My first attempt was to dissassemble, correct and override the DSDT but
> >| the single bug found and corrected (a common ByteAccess type) didn't
> >| change anything.
> >
> >the hardware/software acpi implementation on your laptop is independent
> >of the platform, whether it is centrino or other.
> >
> >after inspection of your dsdt i didn't find references to any thermal 
> >zones.
> >
> >for example, page 287 of the acpi specificatoin 2.0c states that every
> >thermal zone MUST have a _TMP object. there is no _TMP object on your
> >dsdt, so i deduct one of two things:
> >1. your acpi code is not compliant with the standard
> >or
> >2. you really don't have thermal zones.
> >
> >since there are no _CRT, _HOT, _ALx, _PSL, _PSV, _SCP, _TMP, _TZD, _TZP
> >and unless there is/are other place/places where thermal zones are
> >defined, i conclude that you don't have thermal zones defined.
> >
> >maybe someone else could confirm this...
> >
> >is that odd? i don't know... i am just learning ACPI now, so i don't
> >have the experience.
> 
> If you don't have a ThermalZone object, you don't have thermal zones. 
> It's quite common -- it means that the BIOS will handle fans independent 
> of the OS or ACPI.

Or that a thermal sensor will handle that OK already..

Anyway, there is a CTMP in the EC space which may be actually the
temperature of the CPU likely..  I guess you may try something I wroten
for one laptop some years ago which worked for me.

You may try then to add some passive cooling stuff after if that work,
etc.


--- hp_pavilion_zt3240ea_dsdt.dsl	2004/10/13 12:15:12	1.1
+++ hp_pavilion_zt3240ea_dsdt.dsl	2004/10/13 12:27:51
@@ -2596,6 +2596,22 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
                     }
                 }
 
+		ThermalZone (THM0) {
+			Method (_CRT, 0, NotSerialized) {
+				Return(0xe30)	/* 100 C */
+			}
+			Method (_TMP, 0, NotSerialized) {
+				If(\_SB.C046.C059.C0EA.C0ED) {
+					Store(\_SB.C046.C059.C0EA.CTMP, Local0)
+					Multiply(Local0, 10, Local0)
+					Add(Local0, 2732, Local0)
+					Return(Local0)
+				} Else {
+					Return(0xBAD)	/* 26C */
+				}
+			}
+		}
+
                 Device (C140)
                 {
                     Name (_HID, EisaId ("WEC0518"))



Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
