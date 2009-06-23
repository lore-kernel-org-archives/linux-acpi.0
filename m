From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: BIOS and CPU C_states are strange
Date: Mon, 22 Jun 2009 23:16:09 -0600
Message-ID: <4A406519.7000105@gmail.com>
References: <1acba2fa0906191006i3cd5a035pf18e096fdb92e27e@mail.gmail.com>	 <1acba2fa0906191007l4b8d5c17id068d868e6178fb8@mail.gmail.com>	 <a8ca10150906200826l37a7ee2fs283ecfa955697c49@mail.gmail.com>	 <1acba2fa0906200846r751cf235q9e155e5445090d40@mail.gmail.com>	 <a8ca10150906201504p2186b3fbg5ac7761946f48697@mail.gmail.com>	 <1acba2fa0906210218o59a6c92fi86e30891c0816b5d@mail.gmail.com>	 <1acba2fa0906210220p27b9e902xd640029fa0122b24@mail.gmail.com>	 <1245634477.3611.40.camel@localhost.localdomain> <1acba2fa0906212354r40122f0i1f1cb50642cf7e23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f196.google.com ([209.85.210.196]:64944 "EHLO
	mail-yx0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbZFWFW3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Jun 2009 01:22:29 -0400
Received: by yxe34 with SMTP id 34so333936yxe.33
        for <linux-acpi@vger.kernel.org>; Mon, 22 Jun 2009 22:22:31 -0700 (PDT)
In-Reply-To: <1acba2fa0906212354r40122f0i1f1cb50642cf7e23@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mahmood Naderan <mahmood.nt@gmail.com>
Cc: linux-acpi@vger.kernel.org

On 06/22/2009 12:54 AM, Mahmood Naderan wrote:
> Hi,
> My first question was why CPU states are different from BIOS? If C4
> and C5 are good, why and for what reason, the BIOS does not support
> it. This means that BIOS does not like power saving sates (!)
>
> After that I wondered why my system does not even support C3. So you
> and Edward said that C3 is mapped to C6. It is understanable that OS
> map C3 to C6, but since ACPI is a standard, why should CPU, BIOS and
> OS each one say something different. I am not so expert but I think it
> is a little bit confusing.

It's the BIOS that does the mapping in terms of what C-states are 
exposed to the OS. Before ACPI 2.0, only C-states up to C3 were defined. 
ACPI 2.0 allows more C-states, but I don't know if Windows actually 
supports them. (Not sure if Windows has full ACPI 2.0 support yet.) That 
may be why the BIOS people did it that way.
