From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[2/6]-ACPI Eject interface support
Date: Mon, 27 Sep 2004 13:09:17 -0500
Sender: linux-ia64-owner@vger.kernel.org
Message-ID: <200409271309.17756.dtor_core@ameritech.net>
References: <20040920092520.A14208@unix-os.sc.intel.com> <200409270112.29422.dtor_core@ameritech.net> <20040927095348.A29594@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <20040927095348.A29594@unix-os.sc.intel.com>
Content-Disposition: inline
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: Len Brown <len.brown@intel.com>, acpi-devel@lists.sourceforge.net, LHNS list <lhns-devel@lists.sourceforge.net>, Linux IA64 <linux-ia64@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Monday 27 September 2004 11:53 am, Keshavamurthy Anil S wrote:
> =A0=A0=A0=A0=A0=A0=A0=A0I just wanted to have a single function i.e s=
etup_sys_fs_device_files() for both
> creating and removing sysfs files.

Ah, I see... Makes sense, especially when there is additional logic inv=
olved
in creating some of the attributes, which is the case with ACPI.

--=20
Dmitry
-
To unsubscribe from this list: send the line "unsubscribe linux-ia64" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
