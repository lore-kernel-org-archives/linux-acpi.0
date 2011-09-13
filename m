From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [Bug 42502] PROBLEM: USB 1.1 (and up) not working on AMD R900
 Series chipset
Date: Tue, 13 Sep 2011 11:54:54 -0600
Message-ID: <CAErSpo6iD443d1XRBdCxYFeAQeL=zAPGbW+S16w7fbY-CPwguA@mail.gmail.com>
References: <bug-42502-20552@https.bugzilla.kernel.org/> <201109072200.p87M0G5V011358@demeter1.kernel.org>
 <4E6805A7.7080806@schinagl.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:2172 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754344Ab1IMRzR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Sep 2011 13:55:17 -0400
Received: from wpaz9.hot.corp.google.com (wpaz9.hot.corp.google.com [172.24.198.73])
	by smtp-out.google.com with ESMTP id p8DHtFjQ016302
	for <linux-acpi@vger.kernel.org>; Tue, 13 Sep 2011 10:55:16 -0700
Received: from gxk7 (gxk7.prod.google.com [10.202.11.7])
	by wpaz9.hot.corp.google.com with ESMTP id p8DHqqkI020204
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 13 Sep 2011 10:55:14 -0700
Received: by gxk7 with SMTP id 7so815573gxk.35
        for <linux-acpi@vger.kernel.org>; Tue, 13 Sep 2011 10:55:14 -0700 (PDT)
In-Reply-To: <4E6805A7.7080806@schinagl.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Schinagl <oliver@schinagl.nl>
Cc: linux-acpi@vger.kernel.org

On Wed, Sep 7, 2011 at 6:00 PM, Oliver Schinagl <oliver@schinagl.nl> wrote:
> I've uploaded an error log to the bugzilla [1] ...

> [1] https://bugzilla.kernel.org/show_bug.cgi?id=42502

Hi Oliver,

The kernel.org bugzilla is dead at the moment, so I can't look at your
logs.  Can you attach them to an email response or put them somewhere
else where we could get at them?  Just the 32-bit Ubuntu dmesg
(attachment 71942) and the 64-bit Ubuntu dmesg (71952) should be
enough to start with.

Bjorn
