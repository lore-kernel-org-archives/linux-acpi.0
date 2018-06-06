From: Jakub Racek <jracek@redhat.com>
Subject: Re: Performance drop on kernel-4.17 visible on Stream, Linpack and
 NAS parallel benchmarks
Date: Wed, 6 Jun 2018 14:50:22 +0200
Message-ID: <20180606125009.GA29162@jra-laptop.brq.redhat.com>
References: <20180606122731.GB27707@jra-laptop.brq.redhat.com>
 <CAJZ5v0hTTe9zYwYKtoQKjJJbazFeaGVO2SdbaODyvTFiNpGTdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hTTe9zYwYKtoQKjJJbazFeaGVO2SdbaODyvTFiNpGTdw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

+++ Rafael J. Wysocki [06/06/18 14:34 +0200]:
>On Wed, Jun 6, 2018 at 2:27 PM, Jakub Racek <jracek@redhat.com> wrote:
>> Hi,
>>
>> There is a huge performance regression on the 2 and 4 NUMA node systems on
>> stream benchmark with 4.17 kernel compared to 4.16 kernel. Stream, Linpack
>> and NAS parallel benchmarks show upto 50% performance drop.
>
>OK, and why do you think that it is related to ACPI?

I don't know where the problems is or who to CC. 

What information should be added? I can probably provide it, if I know
what.

>Thanks,
>Rafael
