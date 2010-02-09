From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>
Subject: Re: 2.6.33-rc7-next-20100208: recursive locking in __driver_attach()
Date: Tue, 9 Feb 2010 09:57:40 +0800
Message-ID: <2375c9f91002081757r26217bdas9b352f27ad4c5060@mail.gmail.com>
References: <20100208185429.GA4765@x200> <201002082032.58482.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201002082032.58482.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 9, 2010 at 3:32 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Well, I guess sysfs lockdep annotations strike again ...
>

Nope, this is a known issue of core driver code, which is being handled
by Alan Stern.
