From: Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Toshiba Satellite P10
Date: Sat, 24 Dec 2005 09:54:03 +0100
Message-ID: <20051224085403.GB23539@suse.de>
References: <20051223111239.GB10748@elf.ucw.cz> <43AC2B95.9060901@kroon.co.za> <20051223172459.GB15357@elf.ucw.cz> <43AC80F3.6040605@kroon.co.za> <20051223230133.GC16104@elf.ucw.cz> <43AC9127.10007@kroon.co.za> <20051224002527.GA16285@elf.ucw.cz> <43AC97E7.1030800@kroon.co.za> <20051224003808.GB16285@elf.ucw.cz> <43AD0AC6.9060904@kroon.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <43AD0AC6.9060904-P18QfuJFXGPYkQIYctQFYw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jaco Kroon <jaco-P18QfuJFXGPYkQIYctQFYw@public.gmane.org>
Cc: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, Holger Macht <hmacht-l3A5Bk7waGM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Dec 24, 2005 at 10:45:58AM +0200, Jaco Kroon wrote:
> Pavel Machek wrote:
> > rc5 should be good enough.
>=20
> Same problem.  SysRq+T reveals that the newly spawned process is gettin=
g
> stuck in:
>=20
> ide_do_request+0x18a/0x3c5
> io_schedule+0xe/0x16
> sync_page+0x3e/0x4b
> __wait_on_bit_lock+0x41/0x61
> sync_page+0x0/0x4b
> __lock_page+0x9d/0xb1
> wake_bit_function+0x0/0x55
> wake_bit_function+0x0/0x55
> do_generic_mapping_read+0x335/0x7fd
> __generic_file_aio_read+0x19d/0x203
> file_read_actor+0x0/0xfa
> generic_file_read+0xba/0xd8
> autoremove_wake_function+0x0/0x57
> vfs_read+0x1a5/0x1aa
> kernel_read+0x50/0x5f
> prepare_binprm+0xd8/0x103
> do_execve+0xfe/0x203
> sys_execve+0x3c/0x6f
> sysenter_past_esp+0x54/0x75

To my untrained eye this looks like an IDE suspend / resume problem.
Maybe another machine that needs those ACPI methods for the IDE drives
badly :-(
--=20
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, N=FCrnberg \                    -- Leonard Cohe=
n


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
