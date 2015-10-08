From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [Dell XPS 13 9343] Random kernel Oops at boot with "acpi=ht",
 disappearing with "acpi=off"
Date: Thu, 8 Oct 2015 13:28:16 +0300
Message-ID: <20151008102816.GP1506@lahna.fi.intel.com>
References: <16367d85-fe84-4792-819a-d50a508409ef@linuxsystems.it>
 <20151002101919.GZ1551@lahna.fi.intel.com>
 <c4c8d5aa-d2ad-4448-9ca5-d381c30ba6d7@linuxsystems.it>
 <20151005104645.GA1506@lahna.fi.intel.com>
 <97e73880-b4a6-4118-bf11-6a90d2505fd1@linuxsystems.it>
 <20151005135449.GF1506@lahna.fi.intel.com>
 <481e7bc8-b4c4-4acd-9988-f3e0e5ea87b3@linuxsystems.it>
 <20151008100615.GO1506@lahna.fi.intel.com>
 <9517e70c-d3ec-4dd0-8064-a06546812d16@linuxsystems.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:11070 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755220AbbJHK2T (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Oct 2015 06:28:19 -0400
Content-Disposition: inline
In-Reply-To: <9517e70c-d3ec-4dd0-8064-a06546812d16@linuxsystems.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?iso-8859-1?Q?Niccol=F2?= Belli <niccolo.belli@linuxsystems.it>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, Oct 08, 2015 at 12:17:39PM +0200, Niccol=F2 Belli wrote:
> Il gioved=EC 8 ottobre 2015 12:06:15 CEST, Mika Westerberg ha scritto=
:
> >On Mon, Oct 05, 2015 at 05:59:38PM +0200, Niccol=F2 Belli wrote:
> >>Il luned=EC 5 ottobre 2015 15:54:49 CEST, Mika Westerberg ha scritt=
o: ...
> >
> >It looks like a memory corruption somewhere. Unfortunately it is not
> >obvious from the log where :-(
>=20
> It seems I'm the only one with this issue, both Dell and an Aaron Lu =
(an
> Intel employee which uses Fedora) told me they don't experience it:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D105251
> So maybe it has something to do with my configuration, maybe the comb=
o
> dm-crypt + btrfs which is pretty unusual, but I really don't know.

You may want to try another distro if it reproduces.

> If you can tell me how to obtain a more useful log I can provide it.

Other than dmesg, I have no idea :-/ Maybe full crashdump but then it
needs someone who is able to analyze it properly.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
