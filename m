From: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Subject: Re: Smart Battery System driver
Date: Wed, 19 Jan 2005 22:55:31 +0100
Message-ID: <m28y6pytgs.fsf@phoenix.squirrel.nl>
References: <41E81C2C.8010809@bartol.udel.edu>
	<41EDE2EA.7090404@bartol.udel.edu>
	<200501191949.03558.Jeroen.Wijnhout@kdemail.net>
	<200501192010.25975.o.jansen@orb-net.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200501192010.25975.o.jansen-n+qsWun7DryELgA04lAiVw@public.gmane.org> (Olaf Jansen-Olliges's
 message of "Wed, 19 Jan 2005 20:10:25 +0100")
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

Olaf Jansen-Olliges <o.jansen-n+qsWun7DryELgA04lAiVw@public.gmane.org> writes:

> you should not have ac_adapter or battery before "modprobing" have
> you diabled the ac_adapter and battery section in your kernel
> configuration? (as mentioned in the README)

This is (in) my rc.local:

    # Experimental: drivers for smartbattery reading.
    modprobe i2c-dev
    modprobe i2c-acpi-ec
    modprobe -r ac
    modprobe -r battery
    modprobe acpi-sbs

-- Johan


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
