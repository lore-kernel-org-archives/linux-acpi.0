From: =?ISO-8859-15?Q?=22Bernhard_J=2E_M=2E_Gr=FCn=22?= <bjmg-sTHzDQm4gCI@public.gmane.org>
Subject: MSI S260 fan controlling problem
Date: Mon, 12 Sep 2005 19:12:54 +0200
Message-ID: <4325B716.4060701@h0t.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hello,

I am owner of a MSI S260. This notebook has a fan that runs all the time
(beginning with 40=B0C). This problem occurs on Windows and Linux but I
think that I have found the error in the DSDT. I am not that good in
coding DSDTs therefore I hope that someone of you can help me changing
the DSDT to correct that annoying bug.

Here is some of the relevant code (at least I think so):
                            Scope (\_SB)

                {
                    Method (\KELV, 1, NotSerialized)
                    {
                        Store (Arg0, Local2)
                        Multiply (0x0A, Local2, Local2)
                        Add (Local2, 0x0AAC, Local2)
                        Return (Local2)
                    }

                    Name (\PLCY, 0x00)
                    Name (\BAC0, 0x78)
                    Name (\BPSV, 0x73)
                    Name (\BCRT, 0x64)
                    Name (\BTMP, 0x28)
                    Method (\UDTT, 0, NotSerialized)
                    {
                        Store (\_SB.PCI0.SBRG.EC.CPUT, Local0)
                        And (Local0, 0xFF, \BTMP)
                    }

                    Scope (\_TZ)
                    {
                        ThermalZone (THRM)
                        {
                            Method (_TMP, 0, NotSerialized)
                            {
                                If (\_SB.PCI0.SBRG.EC.MYEC)
                                {
                                    \UDTT ()
                                    And (\BTMP, 0xFF, Local0)
                                    Store (\KELV (Local0), Local1)
                                    Return (Local1)
                                }
                                Else
                                {
                                    And (\BTMP, 0xFF, Local0)
                                    Return (Local0)
                                }
                            }


Look at this code:
                    Name (\PLCY, 0x00)
                    Name (\BAC0, 0x78)
                    Name (\BPSV, 0x73)
                    Name (\BCRT, 0x64)
                    Name (\BTMP, 0x28)

The fan starts at 40=B0C and 0x28 (hex) is equals to 40 (dec). Also the
other code around it seems to be relevant to the fan control. But the
problem is that the OS doesn't have access to the fan (no content in /pro=
c/acpi/fan/) to control whether
it runs or not.
After changing the value of BTMP (and doing all mkinitrd stuff) the fan s=
till runs. If I change the CRT (critical) the systems shows the new value=
. Therefore I am sure that the new DSDT is loaded but the fan still runs =
all the time.
I could send the whole DSDT to the list but first I wait for someone who =
thinks that he can help me. Again: this problem exists since many months =
and ALL owner of the S260 have the same problem.

Many thanks for reading my mail!


--=20

*Bernhard Gr=FCn*



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
