From: Frank Mehnert <fm3-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org>
Subject: Re: lid state?
Date: Mon, 7 Oct 2002 16:22:41 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E17yYmP-0004wp-00@noys.inf.tu-dresden.de>
References: <3D9FC692.6050005@prairienet.org> <OE13CngokVNTmgEVg3U0000c5a1@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <OE13CngokVNTmgEVg3U0000c5a1-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: ACPI Development - Sourceforge <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Monday 07 October 2002 14:10, Derek Broughton wrote:
> From: "John Belmonte" <jvb-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>
>
> > What is the correct way to detect the lid state on a lid event?  I've
> > seen some mention of using a counter, but as the lid could be closed
> > before acpid starts up, it doesn't seem very robust.
>
> It's far from ideal, but it's robust enough, because the lid state bears no
> connection to acpid.  Whether or not acpid is running, events get
> generated. I suppose, conceivably, the lid could be closed when the system
> boots and ACPI starts - but how realistic is that?  I can't see it
> happening on my system.

Very realistic if you have attached an external monitor to your notebook.

Frank
-- 
Frank Mehnert
## Dept. of Computer Science, Dresden University of Technology, Germany ##
## E-Mail: fm3-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org    http://os.inf.tu-dresden.de/~fm3 ##


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
