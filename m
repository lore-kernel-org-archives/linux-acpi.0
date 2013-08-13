From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] Protect cpu map updates from ACPI processor
Date: Tue, 13 Aug 2013 13:47:49 +0200
Message-ID: <1497141.gLtk1PtyFs@vostro.rjw.lan>
References: <1376322354-13026-1-git-send-email-toshi.kani@hp.com> <2206062.QmFJav0XuL@vostro.rjw.lan> <1376355303.10300.376.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1376355303.10300.376.camel@misato.fc.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, isimatu.yasuaki@jp.fujitsu.com
List-Id: linux-acpi@vger.kernel.org

On Monday, August 12, 2013 06:55:03 PM Toshi Kani wrote:
> On Tue, 2013-08-13 at 02:43 +0200, Rafael J. Wysocki wrote:
> > On Monday, August 12, 2013 09:45:52 AM Toshi Kani wrote:
> > > CPU system maps are protected with reader/writer locks.  The reader
> > > lock, put_online_cpus(), assures that the maps are not updated while
> > > holding the lock.  The writer lock, cpu_hotplug_begin(), is used to
> > > udpate the cpu maps along with cpu_maps_update_begin().
> > > 
> > > However, the ACPI processor handler updates the cpu maps without
> > > holding the the writer lock.  This patchset fixes this problem.
> > > 
> > > ---
> > > The patchset is based on linux-next of the pm tree.
> > 
> > Basically looks OK to me, but I'd just merge the patches together,
> > because the [2/2] is the very reason for the change made by [1/2].
> 
> I separated for reviewing purpose, but yes, they can be together.  Let
> me know if you need me to re-send it together.

I combined them and added a changelog built out of the messages you sent in
this thread.  Please check:

http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=b9d10be7a8e88fdcb12540387c219cdde87b0795

Thanks,
Rafael
