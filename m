From: Thomas White <taw27-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: patch -p1 acpi-20021002-2.4.19.diff
Date: Sun, 27 Oct 2002 20:01:36 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021027200136.5cb1014a.taw27@cam.ac.uk>
References: <200210272015.09350.ruud.koendering@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200210272015.09350.ruud.koendering-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 27 Oct 2002 20:15:08 +0100
ruud koendering <ruud.koendering-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org> wrote:

> patch -p1 acpi-20021002-2.4.19.diff against mandrake kernel
> 2.4.19-16mdk in /usr/src/linux NOT working att all.
> 
> execution hangs only cntrl-c gives control back.

Try this instead:

patch -p1 < acpi-20021002-2.4.19.diff

______________________
Thomas White
Downing College
Cambridge


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
