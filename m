From: Erico M Mendonca <erico-cz9lu//xMc+vYRxJAoKWRg@public.gmane.org>
Subject: Toshiba 1905S303: update
Date: Sun, 14 Dec 2003 00:50:59 -0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FDBD013.3070709@techisa.srv.br>
Reply-To: erico-cz9lu//xMc+vYRxJAoKWRg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
List-Id: linux-acpi@vger.kernel.org

Updating on my problem with Fn-F5 (switch video out) hanging the machine...

I recompiled the latest known kernel working for me (2.4.21-013mdk,
shipped with Mandrake 9.1) with ACPI debug, and the current DSDT table
I'm using. I do see "QUERY_1C" messages with this kernel on
/var/log/messages, whereas with a newer kernel I do not (the machine
hangs first...).

I have this in my DSDT:

                    Method (_Q1C, 0, NotSerialized)
                    {
                        Store ("=====QUERY_1C=====", Debug)
                        If (\_SB.PCI0.LPC0.EC0.VIDO)
                        {
                            PHSS (0x01)
                            Store (0x00, \_SB.PCI0.LPC0.EC0.VIDO)
                        }
                    }


So the problem would be related to EC code. Were there any significant
changes to this code that could be causing this?

-- 

-- Erico Mendonca
Techisa do Brasil







-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
