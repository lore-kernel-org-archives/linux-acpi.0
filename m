From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Wed, 19 Jan 2005 17:24:23 -0500
Message-ID: <41EEDE17.9040204@bartol.udel.edu>
References: <41E81C2C.8010809@bartol.udel.edu>	<41EDE2EA.7090404@bartol.udel.edu>	<200501191949.03558.Jeroen.Wijnhout@kdemail.net>	<200501192010.25975.o.jansen@orb-net.de> <m28y6pytgs.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m28y6pytgs.fsf-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Johan Vromans wrote:
> Olaf Jansen-Olliges <o.jansen-n+qsWun7DryELgA04lAiVw@public.gmane.org> writes:
> 
> 
>>you should not have ac_adapter or battery before "modprobing" have
>>you diabled the ac_adapter and battery section in your kernel
>>configuration? (as mentioned in the README)
> 
> 
> This is (in) my rc.local:
> 
>     # Experimental: drivers for smartbattery reading.
>     modprobe i2c-dev
>     modprobe i2c-acpi-ec
>     modprobe -r ac
>     modprobe -r battery
>     modprobe acpi-sbs

Note that i2c-dev isn't needed by i2c-acpi-ec or acpi-sbs. Also,
you can get acpi-sbs to automatically load i2c-acpi-ec by adding the line

below acpi-sbs i2c-acpi-ec

...to /etc/modules.conf. With this line in place, your rc.local would 
look like

modprobe -r ac
modprobe -r battery
modprobe acpi-sbs

cheers,

Rich


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
