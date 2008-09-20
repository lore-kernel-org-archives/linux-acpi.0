From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Thinkpad T60p does not recover from Suspend when docked.
Date: Sat, 20 Sep 2008 03:59:28 -0700 (PDT)
Message-ID: <180616.16497.qm@web52911.mail.re2.yahoo.com>
References: <48D3C67B.70909@yahoo.com>
Reply-To: rankincj@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from web52911.mail.re2.yahoo.com ([206.190.49.21]:38093 "HELO
	web52911.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751421AbYITK7a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 20 Sep 2008 06:59:30 -0400
In-Reply-To: <48D3C67B.70909@yahoo.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sitsofe Wheeler <sitsofe@yahoo.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

--- On Fri, 19/9/08, Sitsofe Wheeler <sitsofe@yahoo.com> wrote:
> If you are using binary only graphics card drivers does the
> problem also happen without them never loaded at all?

I have just replicated the problem exactly without the fglrx module (ever) loaded at all, and using the very latest radeonhd DDX driver instead. So this really IS *just* to do with the SATA drive in the docking station.

Cheers,
Chris




      
