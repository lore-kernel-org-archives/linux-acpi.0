From: Olive Esseret <olive_esseret-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: power is always C2 on toshiba A40 261
Date: Wed, 23 Jun 2004 05:25:35 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040623122535.44750.qmail@web90004.mail.scd.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2112549848-1087993535=:41769"
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

--0-2112549848-1087993535=:41769
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Hello,

Excuse me if this question is not appropriate here.

I am using a Toshiba A40 261 laptop on a Mandrake 10.0
distribution with a 2.6.3-7mdk kernel (I attach the
output of lspci -vv and lsmod).

I face the following problem:

The content of the file 

/proc/acpi/processor/CPU0/power
(see attached file power.txt.bz2)

shows that I am *always* in C2 sate. I see also that I
was been on a C1 state for a period of 00000010. This
period of 00000010 remains always exactly 00000010
even after rebooting, load the processor, etc.

Olive


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
--0-2112549848-1087993535=:41769
Content-Type: application/x-bzip; name="power.txt.bz2"
Content-Transfer-Encoding: base64
Content-Description: power.txt.bz2
Content-Disposition: attachment; filename="power.txt.bz2"

QlpoOTFBWSZTWUsem9sAAEnfgHTRQBJ/8AgAAAo/p98gMAC6UMiUxqaNqPSA
PEgD9UPUMaNGgGTIaMRpoGmA2kqNHqGR6gAAAabUkZOjhbN5mnjqBFiwIcL5
hR9t73irmtasRCTTWC0xQKiIRylSmyd1I1iMoPlzjPJQ5GGcXhEUCEJ6MN4g
6za6XHEtIMU6W9xrKvNbQxYBSH7kHm85gbmpFHdJNsGey5E0Wl+hKGSU69Gk
gTdaKLS6ry4arD/F3JFOFCQSx6b2wA==

--0-2112549848-1087993535=:41769
Content-Type: application/x-bzip; name="lspci.txt.bz2"
Content-Transfer-Encoding: base64
Content-Description: lspci.txt.bz2
Content-Disposition: attachment; filename="lspci.txt.bz2"

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

--0-2112549848-1087993535=:41769
Content-Type: application/x-bzip; name="lsmod.txt.bz2"
Content-Transfer-Encoding: base64
Content-Description: lsmod.txt.bz2
Content-Disposition: attachment; filename="lsmod.txt.bz2"

QlpoOTFBWSZTWeBvJE0AAgP/gBP/8ABABn/gAAIKAL////BQAz5djXddcB04
iaEw1NJtNEAABhAD1ADUzUmjTIap6nkAEaGgNoIyYGp5NUk0flNTGUD1GmEY
RkBiGhgAAAABoNAGgGgEiQmQmJkNFT8qbUGgafqnqB6htJohHR/Fo9n/L9f3
gXZ+7F8nYZ6v/HWpg5xPCdpCQEfBr0ZAxphk19zSJTokkgt5HhfFa8KAyAqZ
0WigGqfIaKHj7WEISwcyLWzPPO4xJ71th8ZdhE2H0ittQSiIabgRJFmCgymQ
wyzAaiSUjTsCS0l2HR85BDGOJSlbW2OOq57ynB1Kas306NYT8yPqJryYF6VE
oTRfGTghwpCF/SZqtPcNxCcb7wzpvQqRKaks+8bXxdWva0YYperEQvgE6yaa
2vjuZQDuS08SJapEU0g+yp7wsgm+VAIOlxxQcYb0iablQVJZXxKrNa/K/DM8
4X4WMboIus/jk2cs7qK4ilHONlsvuVzgrpXit6vntYkaUCyD5j1ZiJbUYvpw
1RE6e7VeS/z2WxMqlVwwGK4vm6wWbb1RmhQ9bwQZEoITgwwnqtWszxe8pg2H
jB98aErRrTFqghD4LpsYh29qEiUq5VaUVmMR00Bk040qUVLr1wCtk+vHVELr
cAh69hMPiYh/uN3MvYWg/gXCEzPkFIUAVMjSv+gC2a98JaxKD5riO2JaQawX
WQVNvPGmd3927tjccK5zKToIRwcEj2v/bMoK3Ha28zpDvf4/SUzkEWvP96oM
1oa7FhKD2OxXj9FkuHNQZy7OuJHaaVQ8Zt1K11wL+sBkFLoz2GTz1SxIlmk+
9D3kXrLU4oNY67eLPxevDR4HS2581qps1DAhX13BIzrojBBHAppEGwZnvPpR
qa5BGaROp6fDBtbXcDrIkBIpjfw0YymK0kJbPw1VSV2ChTOK8cxTGy6lUfZc
hI4uoAXrUOVBKTtnjUC5SKKSSRIJSKCJiFDbiGnGvQyndSHVI0vT79G4GEeh
BA2g0eV9SeKkcuPNXLKnLOUmxvCR30VmLAPyS5Eij1kSv4u5IpwoSHA3kiaA


--0-2112549848-1087993535=:41769--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
