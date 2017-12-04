From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] ACPI / battery: add quirk for Asus GL502VSK and UX305LA
Date: Mon, 04 Dec 2017 15:47:38 +0100
Message-ID: <7945697.1Vbycb5uoE@aspire.rjw.lan>
References: <20171121083306.17826-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44205 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752163AbdLDOsL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Dec 2017 09:48:11 -0500
In-Reply-To: <20171121083306.17826-1-kai.heng.feng@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, November 21, 2017 9:33:06 AM CET Kai-Heng Feng wrote:
> From: Kai Heng Feng <kai.heng.feng@canonical.com>
> 
> On Asus GL502VSK and UX305LA, ACPI incorrectly reports discharging when
> battery is full and AC is plugged.
> 
> However rate_now is correct under this circumstance, hence we can use
> "rate_now == 0" as a predicate to report battery full status correctly.
> 
> BugLink: https://bugs.launchpad.net/bugs/1482390
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied, thanks!

Rafael

