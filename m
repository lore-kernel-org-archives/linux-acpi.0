From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[2/6]-ACPI Eject interface support
Date: Mon, 27 Sep 2004 01:12:28 -0500
Sender: linux-ia64-owner@vger.kernel.org
Message-ID: <200409270112.29422.dtor_core@ameritech.net>
References: <20040920092520.A14208@unix-os.sc.intel.com> <200409201812.45933.dtor_core@ameritech.net> <20040924162823.B27778@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <20040924162823.B27778@unix-os.sc.intel.com>
Content-Disposition: inline
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: Len Brown <len.brown@intel.com>, acpi-devel@lists.sourceforge.net, LHNS list <lhns-devel@lists.sourceforge.net>, Linux IA64 <linux-ia64@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Friday 24 September 2004 06:28 pm, Keshavamurthy Anil S wrote:
> +typedef void acpi_device_sysfs_files(struct kobject *,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0const struct attribute *);
> +
> +static void setup_sys_fs_device_files(struct acpi_device *dev,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0acpi_device_sysfs_files=
 *func);
> +
> +#define create_sysfs_device_files(dev)=A0\
> +=A0=A0=A0=A0=A0=A0=A0setup_sys_fs_device_files(dev, (acpi_device_sys=
fs_files *)&sysfs_create_file)
> +#define remove_sysfs_device_files(dev)=A0\
> +=A0=A0=A0=A0=A0=A0=A0setup_sys_fs_device_files(dev, (acpi_device_sys=
fs_files *)&sysfs_remove_file)


Hi Anil,

It looks very nice except for the part above. I am really confused what=
 the
purpose of this code is... It looks like it just complicates things?

--=20
Dmitry
-
To unsubscribe from this list: send the line "unsubscribe linux-ia64" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
