From: "James H. Cloos Jr." <cloos-GRsvFm/Gh/pBDgjK7y7TUQ@public.gmane.org>
Subject: Re: ACPI Battery Problems
Date: 07 Jul 2003 15:40:34 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m3adbq3z2l.fsf@lugabout.jhcloos.org>
References: <20030704195241.GC7074@roadrunner.ichilton.net>
	<03f101c34268$501e4960$3746028e@bio.dfo.ca>
	<m3znjrmj1e.fsf@lugabout.jhcloos.org>
	<20030707123833.GB7796@poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030707123833.GB7796-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Derek Broughton <dbroughton-F3m4/jXepmf3fQ9qLvQP4Q@public.gmane.org>, ACPI Development - Sourceforge <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--=-=-=

>>>>> "Ducrot" == Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> writes:

Ducrot> Most of ASL I saw will more likely use the _OSI() method for
Ducrot> Windows XP.  I'm also wondering if that will be OK to
Ducrot> implement it (but with a configure option or perhaps better a
Ducrot> boot option).

Yes, I did miss that.  Dell does this:


--=-=-=
Content-Type: text/x-asl
Content-Disposition: inline

Method (OSID, 0, NotSerialized)
    {
        If (LEqual (MIS3, 0x00))
        {
            Store (0x04, MIS3)
            If (CondRefOf (\_OSI, Local0))
            {
                If (\_OSI (WXP))
                {
                    Store (0x40, MIS3)
                }
            }
            Else
            {
                If (STRE (\_OS, W98S))
                {
                    Store (0x08, MIS3)
                }

                If (STRE (\_OS, NT5S))
                {
                    Store (0x10, MIS3)
                }

                If (STRE (\_OS, WINM))
                {
                    Store (0x20, MIS3)
                }
            }
        }

        Return (MIS3)
    }

--=-=-=


So I was even wrong about the default.  0x4 is used for anything not
98, nt5, me or xp.

In any case, booting w/ acpi_os_name='Windows 2001' still allows the
battery etc stuff to work, so it is obviously indeed the recent
patches that fixed handling less-than-ideal dsdts.

-JimC

--=-=-=--



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
