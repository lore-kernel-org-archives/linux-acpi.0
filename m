From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: _S0D and \_S0?
Date: Tue, 11 May 2004 18:02:19 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040511174800.K78445@root.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, imp-uzTCJ5RojNnQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

After doing some more analysis, on ASL, it appears some systems (Dell)
have _S0D methods under devices.  It appears the OSPM should run those
at runtime when deciding to change the power state for a device.  Here's
an example:

            Device (USB3)
                Method (_S0D, 0, NotSerialized)
                {
                    Store (SMI (0x85, 0x00), Local0)
                    And (Local0, 0x01, Local0)
                    If (LEqual (Local0, 0x00))
                    {
                        Return (0x03)
                    }
                    Else
                    {
                        Return (0x00)
                    }
                }
                Name (_S1D, 0x02)
                Name (_S3D, 0x02)

This appears to say "if transitioning to another power state and the
system is up and running (i.e. S0), the device must always be powered off
(0x03) if bit 0 of SMI 0x85 is clear.  Otherwise, any power state is fine
(0x00)".

Additionally, some machines have non-zero values for \_S0.  Should we be
writing these values to the wake register at some point?

asl/vaio.asl:Name(_S0_, Package(0x4) {
asl/vaio.asl-    0x5,
asl/vaio.asl-    0x5,
asl/vaio.asl-    0x0,
asl/vaio.asl-    0x0,

Comments welcome.

-Nate


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
