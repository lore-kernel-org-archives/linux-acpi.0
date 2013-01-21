From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v9 09/11] PCI, acpiphp: Don't bailout even no slots found yet.
Date: Sun, 20 Jan 2013 18:42:55 -0800
Message-ID: <CAE9FiQUac48U0o4dr3ONdqeBvGsgHGRtOemTh+4FtKcGVbCG4w@mail.gmail.com>
References: <1358495602-22867-1-git-send-email-yinghai@kernel.org>
	<1358495602-22867-10-git-send-email-yinghai@kernel.org>
	<14158003.3rfOuOmdG2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <14158003.3rfOuOmdG2@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>, Taku Izumi <izumi.taku@jp.fujitsu.com>, Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

>
> If that's the case:
>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> but please say something like this in the changelog:
>
> "The result returned by acpiphp_get_num_slots() is meaningless, because
>  the bridge the slots are under may be added after this function has been
>  called, so drop acpiphp_get_num_slots() and the code using it."

yes, I add you inputs into change log.

Thanks a lot
