From: =?iso-8859-1?Q?Niccol=F2_Belli?= <niccolo.belli@linuxsystems.it>
Subject: Re: [Dell XPS 13 9343] Random kernel Oops at boot with =?iso-8859-1?Q?"acpi=3Dht",_disappearing_with_"acpi=3Doff"?=
Date: Thu, 08 Oct 2015 12:17:39 +0200
Message-ID: <9517e70c-d3ec-4dd0-8064-a06546812d16@linuxsystems.it>
References: <16367d85-fe84-4792-819a-d50a508409ef@linuxsystems.it>
 <20151002101919.GZ1551@lahna.fi.intel.com>
 <c4c8d5aa-d2ad-4448-9ca5-d381c30ba6d7@linuxsystems.it>
 <20151005104645.GA1506@lahna.fi.intel.com>
 <97e73880-b4a6-4118-bf11-6a90d2505fd1@linuxsystems.it>
 <20151005135449.GF1506@lahna.fi.intel.com>
 <481e7bc8-b4c4-4acd-9988-f3e0e5ea87b3@linuxsystems.it>
 <20151008100615.GO1506@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151008100615.GO1506@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Il gioved=C3=AC 8 ottobre 2015 12:06:15 CEST, Mika Westerberg ha scritt=
o:
> On Mon, Oct 05, 2015 at 05:59:38PM +0200, Niccol=C3=B2 Belli wrote:
>> Il luned=C3=AC 5 ottobre 2015 15:54:49 CEST, Mika Westerberg ha scri=
tto: ...
>
> It looks like a memory corruption somewhere. Unfortunately it is not
> obvious from the log where :-(

It seems I'm the only one with this issue, both Dell and an Aaron Lu (a=
n=20
Intel employee which uses Fedora) told me they don't experience it:=20
https://bugzilla.kernel.org/show_bug.cgi?id=3D105251
So maybe it has something to do with my configuration, maybe the combo=20
dm-crypt + btrfs which is pretty unusual, but I really don't know.

If you can tell me how to obtain a more useful log I can provide it.

Thanks,
Niccol=C3=B2 Belli
