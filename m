From: Brice Goglin <Brice.Goglin@ens-lyon.org>
Subject: Re: s4bios: does anyone use it?
Date: Sat, 05 Mar 2005 22:26:19 +0100
Message-ID: <422A23FB.2010707@ens-lyon.org>
References: <20050305191405.GA1463@elf.ucw.cz> <422A1FB6.3000504@ens-lyon.org> <20050305211747.GF1424@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20050305211747.GF1424@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <acpi-devel@lists.sourceforge.net>, seife@suse.de, Len Brown <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

Pavel Machek a =E9crit :
> Can you try cat /proc/acpi/sleep? If there's no difference between S4
> and S4bios, than you are probably just using plain S4...

puligny:~% cat /proc/acpi/sleep
S0 S1 S3 S4 S4bios S5

Where am I suppose to see a difference between S4 and S4Bios here ?


 From what I see in acpi_system_write_sleep in drivers/acpi/sleep/proc.=
c
4 uses software_suspend while 4b uses acpi_suspend(4)
(SOFTWARE_SUSPEND is set in my .config)
Is this code the right one ?

         /* Check for S4 bios request */
         if (!strcmp(str,"4b")) {
                 error =3D acpi_suspend(4);
                 goto Done;
         }
         state =3D simple_strtoul(str, NULL, 0);
#ifdef CONFIG_SOFTWARE_SUSPEND
         if (state =3D=3D 4) {
                 error =3D software_suspend();
                 goto Done;
         }
#endif
         error =3D acpi_suspend(state);

> Yes, but it will take quite long to do it properly. pm_message_t
> framework needs to go in, first.

Ok, great! I'll be happy to test it soon :)

Brice
