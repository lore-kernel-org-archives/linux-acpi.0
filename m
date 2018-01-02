From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / sysfs: fix shift-overflow in GPE flooding quirk mechanism
Date: Tue, 2 Jan 2018 11:18:31 +0100
Message-ID: <CAJZ5v0hcMMd+V4eD76mZt4=qobAzbzviOvDuLmC7KRnw8emdPg@mail.gmail.com>
References: <1513955470-27270-1-git-send-email-changbin.du@intel.com> <20180102063651.3p2bwr467w43twbu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180102063651.3p2bwr467w43twbu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Du, Changbin" <changbin.du@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 2, 2018 at 7:36 AM, Du, Changbin <changbin.du@intel.com> wrote:
> Hi Wysocki and Brown,
> May I know wether you have checked this? Thanks!

There's a commit changing this queued up already, see
https://patchwork.kernel.org/patch/10085579/

Thanks!
