From: Stefan Seyfried <seife@suse.de>
Subject: Re: s4bios: does anyone use it?
Date: Sat, 05 Mar 2005 23:01:13 +0100
Message-ID: <422A2C29.8070209@suse.de>
References: <20050305191405.GA1463@elf.ucw.cz> <422A1FB6.3000504@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <422A1FB6.3000504@ens-lyon.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <acpi-devel@lists.sourceforge.net>, Len Brown <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

Brice Goglin wrote:

>  From what I remember, I didn't see any difference between S4 and S4B=
ios in
> recent vanilla kernels.

I have seen exactly the same thing and concluded that S4bios is broken.
Since it is tricky to set up (you usually need a special hibernation
partition or a special file in a FAT partition) and probably slow as
hell (at least if it has anything to do with the APM BIOS suspend to
disk routines, and i assume it does), i'd shed no tears if it would go
away ;-)
--=20
Stefan Seyfried, QA / R&D Team Mobile Devices, SUSE LINUX N=FCrnberg.

"Any ideas, John?"
"Well, surrounding them's out."
