From: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Subject: Re: About dsdt of clevo 5600N
Date: 16 May 2003 10:44:51 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1053074691.1189.6.camel@dutidad>
References: <20030516021732.69eca85d.XaRz69@terra.es>
	 <20030516035605.18dc60b8.XaRz69@terra.es>
	 <Pine.LNX.4.53.0305160752340.5724@dynast.gaugusch.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.53.0305160752340.5724-sxQ525G0OhRQK2oVCIMtW7NldLUNz+W/@public.gmane.org>
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

On Fri, 2003-05-16 at 07:53, Markus Gaugusch wrote:
> On May 16, Pere Casta=F1er <XaRz69-pCzzcW6XgXY@public.gmane.org> wrote:
> > How can I know if my laptop is capable of doing suspend on Ram (I supos=
e
> > the tipical windows supend mode)? throght the dmesg?  Or I need more
> > patches?
> You have to do 'cat /proc/acpi/sleep' and see if S3 is available.
> Unfortunately, even if it is shown to be supported, it can't work with 2.=
4
> kernels. Maybe try the latest 2.5 kernel, or use swsusp (swsusp.sf.net).

The 5600 supports S3, but you can forget about using it in Linux at this
moment.  There are two problems at the moment, one specific and one
general. =20

Problem one is that the sleep button is not enabled for wakeup, so you
can make the laptop go S3, but you can't wake it up.  It took me weeks
to figure this out.  The experiment ended with a BAD BAD hack to enable
the sleep button for a wakeup event and at least it showed some signs of
life.  The friendly Intel ACPI developers are aware of this problem and
will fix it.

Problem two is of course simply the fact that many drivers don't support
being waked up from S3 yet.  In addition, the information for waking up
a Radeon M7 (which is in the 5600) is not really available.  You can try
the trick Ole Rohne did and repost the Radeon, but this is kludge.

Search the acpi-devel list archives for details.

--=20
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
