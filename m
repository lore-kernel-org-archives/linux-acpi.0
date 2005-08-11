From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: NX6125 has insane thermal trip values
Date: Fri, 12 Aug 2005 00:48:36 +0100
Message-ID: <20050811234836.GA32021@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Booting a 64-bit kernel on an HP nx6125, the thermal trip values are set 
to 16 degrees centigrate by default. This seems to be due to the 
following block of code:

            If (LAnd (LEqual (\_SB.C031, 0x01), LAnd (LEqual (Arg0, 
0x00), LEqu\al (Arg1, 0x00))))
            {
                If (\_SB.C046.C0AD.C110.C164 ())
                {
                    Store (0x0B4B, Local2)
                }
            }

            If (LEqual (\_SB.C046.C054.C055, 0x01))
            {
                Store (0x0B4B, Local2)
            }

            Return (Local2)

which appears to explicitly set those temperatures. I'm assuming that 
this is only supposed to be triggered under a certain set of conditions, 
but HP's insistence on replacing all of their object names with crap 
makes me weep bitter tears of loathing and I really can't be bothered 
tracking this down. I've attached the DSDT - can anyone see any obvious 
reason why this code path should be triggered? I'll get in touch with HP 
anyway, and see if they can fix it in a newer BIOS revision.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
