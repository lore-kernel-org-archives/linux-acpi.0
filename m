From: Ernst Herzberg <earny-euM3SP4ZHrg@public.gmane.org>
Subject: Re: Re: ACPI source patches updated (20021101)
Date: Wed, 6 Nov 2002 02:03:02 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200211060203.02287.earny@net4u.de>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A4BB@orsmsx119.jf.intel.com>
Reply-To: earny-euM3SP4ZHrg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A4BB-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, =?iso-8859-1?q?'S=E9rgio=20Monteiro=20Basto'?= <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Cc: John Summerfield <summer-bdq14YP6qtSeVB85EesmETSf8X3wrgjD@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mittwoch, 6. November 2002 01:16, Grover, Andrew wrote:


> BTW2 the flood of debug messages should *not* crash the system, so if it
> is, that's the real bug to fix.

Hm. If i use a serial console to track the messages, the kernel is 101% busy 
to send it. This seems to be also true, if the console uses a fb-device (you 
don't ever see one message).

<Earny>



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
