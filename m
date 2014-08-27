From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: Monitor does not recover from suspend cycle (kernel 3.16)
Date: Tue, 26 Aug 2014 22:35:33 -0700
Message-ID: <CAOMFOmUK3Cac28Ls1PwgzGXr2U5fY5eNRev8Gtv-XxWspwrF3A@mail.gmail.com>
References: <CAOMFOmXiK89qdDCiXLLiGBBrqRvE6R-OqMuWHK2sawtJ=npjYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:38807 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932340AbaH0Ffd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Aug 2014 01:35:33 -0400
Received: by mail-yk0-f182.google.com with SMTP id q9so12305151ykb.41
        for <linux-acpi@vger.kernel.org>; Tue, 26 Aug 2014 22:35:33 -0700 (PDT)
In-Reply-To: <CAOMFOmXiK89qdDCiXLLiGBBrqRvE6R-OqMuWHK2sawtJ=npjYQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi

On Wed, Aug 20, 2014 at 10:49 PM, Anatol Pomozov
<anatol.pomozov@gmail.com> wrote:
> Hi
>
> I use Linux Arch and recently got kernel 3.16 update. And I started
> seeing an issue with suspend. When I wake up the machine all subsystem
> start working properly (I can ssh machine), but only monitor (Dell
> 2405FPW) stays in "off" state. Power cycling monitor does not help. I
> need to restart my computer to make monitor to work properly again.
> Reverting kernel to 3.15.8 also fixes the issue.
>
> Anyway here is additional information:
>
> acpidump -z  https://gist.githubusercontent.com/anatol/e0f7779195f799d1aaf6/raw/57c882d3ec675e68afdc4f0e74e5ebee1e032256/gistfile1.txt
>
> lshw  https://gist.githubusercontent.com/anatol/d5c28181028720e773bb/raw/947e41f33ed7542faf63174447a44594a7b66d94/gistfile1.txt
>
> dmesg  https://gist.githubusercontent.com/anatol/1465ea7da5f71f5832d4/raw/9b8dc4b187ceca0b5b79bc72f02df683332b97d6/gistfile1.txt
>
> Do you need any additional information?

Oops just found that maillist software ate the links. Here is shorter
version of the data urls

http://bit.ly/1vl6cnw
http://bit.ly/1mQcTWH
http://bit.ly/1zCmS7z
