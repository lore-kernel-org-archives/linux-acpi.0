From: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Subject: Re: Smart Battery System driver
Date: Thu, 20 Jan 2005 10:22:40 +0100
Message-ID: <m2mzv4pi8v.fsf@phoenix.squirrel.nl>
References: <41E81C2C.8010809@bartol.udel.edu>
	<200501192010.25975.o.jansen@orb-net.de>
	<m28y6pytgs.fsf@phoenix.squirrel.nl>
	<200501200936.21831.o.jansen@orb-net.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200501200936.21831.o.jansen-n+qsWun7DryELgA04lAiVw@public.gmane.org> (Olaf Jansen-Olliges's
 message of "Thu, 20 Jan 2005 09:36:21 +0100")
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

> Hi Johan, 
>
>>    # Experimental: drivers for smartbattery reading.
>>    modprobe i2c-dev
>>    modprobe i2c-acpi-ec
>>    modprobe -r ac
>>    modprobe -r battery
>>    modprobe acpi-sbs
>
>
> i've tested it again on my machine. I only get values for my battery
> when i disable in my kernel configuration. Even when they are marked
> to be build as modules i get no values! Perhaps you should try to
> compile a new kernel with this variables set to no.

Sorry for the confusion -- with these settings in my rc.local I _DO_
get correct values, so there should be no need to recompile the kernel
if ac and battery are modules. Just make sure they're unloaded before
you load acpi-sbs.

-- Johan


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
