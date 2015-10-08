From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [Dell XPS 13 9343] Random kernel Oops at boot with "acpi=ht",
 disappearing with "acpi=off"
Date: Thu, 8 Oct 2015 13:06:15 +0300
Message-ID: <20151008100615.GO1506@lahna.fi.intel.com>
References: <16367d85-fe84-4792-819a-d50a508409ef@linuxsystems.it>
 <20151002101919.GZ1551@lahna.fi.intel.com>
 <c4c8d5aa-d2ad-4448-9ca5-d381c30ba6d7@linuxsystems.it>
 <20151005104645.GA1506@lahna.fi.intel.com>
 <97e73880-b4a6-4118-bf11-6a90d2505fd1@linuxsystems.it>
 <20151005135449.GF1506@lahna.fi.intel.com>
 <481e7bc8-b4c4-4acd-9988-f3e0e5ea87b3@linuxsystems.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <481e7bc8-b4c4-4acd-9988-f3e0e5ea87b3@linuxsystems.it>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Niccol=F2?= Belli <niccolo.belli@linuxsystems.it>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Oct 05, 2015 at 05:59:38PM +0200, Niccol=F2 Belli wrote:
> Il luned=EC 5 ottobre 2015 15:54:49 CEST, Mika Westerberg ha scritto:
> >On Mon, Oct 05, 2015 at 03:41:09PM +0200, Niccol=F2 Belli wrote:
> >>Il luned=EC 5 ottobre 2015 12:46:45 CEST, Mika Westerberg ha scritt=
o: ...
> >
> >It says:
> >
> >Mounting /boot...
> >[FAILED] Failed to mount /boot.
> >See 'systemctl status boot.mount' for details.
> >[DEPEND] Dependency failed for Local File Systems.
> >
> >Did you run 'systemctl status boot.mount'?
>=20
> Please do not consider my previous e-mail, becuase the failure was du=
e to
> file loss: in fact sometimes the system hangs while shutting down (I =
think
> because of this bug) and so some modules of my just compiled kernel w=
ere
> loss. I recompiled the kernel once again and synced the disks just to=
 be
> sure: I still get random crashes even with CONFIG_SND_SOC=3Dn.
> See the new log: https://bugzilla.kernel.org/attachment.cgi?id=3D1894=
81

It looks like a memory corruption somewhere. Unfortunately it is not
obvious from the log where :-(
