From: Jeroen Wijnhout <Jeroen.Wijnhout-sVbgdUKTYbrR7s880joybQ@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Thu, 20 Jan 2005 10:10:53 +0100
Message-ID: <200501201010.53247.Jeroen.Wijnhout@kdemail.net>
References: <41E81C2C.8010809@bartol.udel.edu> <200501191949.03558.Jeroen.Wijnhout@kdemail.net> <200501192010.25975.o.jansen@orb-net.de>
Reply-To: Jeroen.Wijnhout-sVbgdUKTYbrR7s880joybQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200501192010.25975.o.jansen-n+qsWun7DryELgA04lAiVw@public.gmane.org>
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

On Wednesday 19 January 2005 20:10, Olaf Jansen-Olliges wrote:
> Hi Joeren,
>
> > I've tried the above driver on my Acer TM4001WLMi and it sort of doesn't
> > work. The problem is that after modprobing i2c_acpi_ec and acpi_sbs I've
> > got two battery and two ac_adapter directories in /proc (very weird if
> > you ask me).
>
> you should not have ac_adapter or battery before "modprobing" have you
> diabled the ac_adapter and battery section in your kernel configuration?
> (as mentioned in the README)

This was enabled, so I will have to recompile the kernel I guess.

best,
Jeroen

P.S.: Next time I will read the README before asking a question ;-)
-- 
Kile - KDE Integrated LaTeX Editor
http://kile.sourceforge.net


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
