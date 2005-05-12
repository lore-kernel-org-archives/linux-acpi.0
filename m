From: ian-bpYUrRpEkwj10XsdtD+oqA@public.gmane.org
Subject: ACPI-0352 error
Date: Thu, 12 May 2005 09:35:48 +0100
Message-ID: <1115886948.4283156406f39@www.turls.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

Hi

Any idea why I get in my boot log.  I think it is the battery status:



ACPI-0352: *** Error: Looking up [Z00D] in namespace, AE_NOT_FOUND
search_node f7f1ec80 start_node f7f1ec80 return_node 00000000
    ACPI-1133: *** Error: [NULL NAME], AE_NOT_FOUND
    ACPI-1133: *** Error: Method execution failed [\_SB_.BAT1._BST] (Node
f7f1ebc0), AE_NOT_FOUND


I am running 2.6.9 kernal on an ACER 1704 laptop

Regards Ian

-------------------------------------------------
This mail was sent through Ian's implemtation of=20
        IMP: http://horde.org/imp/
If this message is not really for you then do not
read it.  Please send an email back to whoever=20
sent it.   =20



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=3D7393&alloc_id=3D16281&op=3Dclick
