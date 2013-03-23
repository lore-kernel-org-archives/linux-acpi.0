From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: pm/linux-next cause network stop working with qemu-kvm/e1000
Date: Sun, 24 Mar 2013 00:43:18 +0100
Message-ID: <1936124.cEBL1gZTc7@vostro.rjw.lan>
References: <CAE9FiQVZ5VZDo1KCun6SDonTJ=TGWLxm5zJQN5U4f1_52cKKwg@mail.gmail.com> <2281042.ltEMndsGee@vostro.rjw.lan> <CAE9FiQWX15yH+7xgOZOg5XuLcoVEaJq3hononPkh5gYoC_C+zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE9FiQWX15yH+7xgOZOg5XuLcoVEaJq3hononPkh5gYoC_C+zw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bob Moore <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Saturday, March 23, 2013 09:18:55 AM Yinghai Lu wrote:
> On Sat, Mar 23, 2013 at 5:30 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> >>
> >> Attached patch fix the problem. Please fold it into offending patch in
> >> pm/linux-next.
> >
> > I'd actually prefer to apply it as a separate patch, so can you please post
> > it with a proper changelog?
> 
> but that will break bisecting, right?

We need to keep ACPICA changes and Linux-specific modifications separate
for process-related reasons.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
