From: Damien Challet <challet-dK2jV70R1GDQzY9nttDBhA@public.gmane.org>
Subject: Incomplete list of pnp entries/resources with pnpacpi
Date: Mon, 24 Jan 2005 17:04:45 +0000
Message-ID: <200501241704.46239.challet@maths.ox.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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

Dear All,

On my thinkpad 600e,

1) pnpacpi does not seem to be as accurate as pnpbios. First of all the number 
of entry points is quite smaller: lspnp stops at 1b, while pnpacpi stops at 
10

2) There is no strict correspondance between the entries:

lspnp gives 

0e CSC0100 multimedia controller: audio
0f CSC0110 multimedia controller: audio
10 CSC0101 multimedia controller: audio
11 CSC0103 multimedia controller: audio

whereas pnpacpi gives

00:05  CSC0110
00:06  CSC0100
00:07  CSC0101

3) The resources allocated to each entry are not complete: 

for instance, pnpbios gives

0e CSC0100 multimedia controller: audio
        io 0x0530-0x0537
        io 0x0388-0x038b
        io 0x0220-0x0233
        irq 5
        dma 0
        dma 1

and pnpacpi

00:06  state = active
io 0x530-0x537

This might be the cause of my sound card not working.

Thanks for any help

Damien




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
