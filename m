From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC]convert ACPI driver model to Linux driver model -
	takes 2
Date: Thu, 13 Oct 2005 16:20:59 +0800
Message-ID: <1129191659.9987.11.camel@linux-hp.sh.intel.com>
References: <3ACA40606221794F80A5670F0AF15F84041AC20F@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC20F@pdsmsx403>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-10-13 at 15:45 +0800, Yu, Luming wrote:
> >+static int __init acpi_phys_bus_init(void)
> >+{
> >+	bus_register(&acpi_phys_bus_type);
> >+
> >+	phys_root = kzalloc(sizeof(struct acpi_phys_device), 
> >GFP_KERNEL);
> >+	if (!phys_root)
> >+		return -ENOMEM;
> >+
> >+	phys_root->acpi_dev = acpi_root;
> >+	phys_root->phys_dev.release = acpi_phys_device_release;
> >+	sprintf(phys_root->phys_dev.bus_id, "%s", 
> >acpi_root->pnp.bus_id);
> >+	device_register(&phys_root->phys_dev);
> >+
> >+	/* enumerate devices */
> >+	acpi_bus_register_driver(&dummy_driver);
> >+	return 0;
> >+}
> 
> The structure is in a mess. why not cut bus.c?
> 
> I like this:
> 
> acpi_bus_init(void)
> {
> ...
> bus_register(&acpi_bus_type);
> ...
> driver_register(&acpi_bus_driver);
> ...
> }
I'm sorry, but I don't understand what do you mean. Can you clarify it?
Also, please focus on the basic idea of how to convert ACPI driver model
in current stage. It appears people have quite different opinions about
the topic. The code is just to show my idea (a RFC) not for merging, so
please ignore possible errors (Not everybody agrees with introducing
ACPI bus, actually). It's my bad not explain this.

Thanks,
Shaohua



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
