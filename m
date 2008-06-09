From: Andi Kleen <andi@firstfloor.org>
Subject: Re: requested info
Date: Mon, 09 Jun 2008 18:58:26 +0200
Message-ID: <87ej76r1e5.fsf@basil.nowhere.org>
References: <200806051743.28470.michael.born@stud.uni-hannover.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out03.alice-dsl.net ([88.44.63.5]:42396 "EHLO
	smtp-out03.alice-dsl.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbYFIQ62 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jun 2008 12:58:28 -0400
In-Reply-To: <200806051743.28470.michael.born@stud.uni-hannover.de> (Michael Born's message of "Thu, 5 Jun 2008 17:43:28 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michael Born <michael.born@stud.uni-hannover.de>
Cc: linux-acpi@vger.kernel.org

Michael Born <michael.born@stud.uni-hannover.de> writes:
> What might be the result of such error message?
> I'm asking because the computer in question has a problem with opensuse 11.0 
> beta3/rc1 and folding@home. After some time the 4 threads of the f@h client 
> dissappear from "top" but are still shown in "ps x" (see below).

When they are in 'D' state please do as root

echo 1 > /proc/sys/kernel/sysrq
echo t > /proc/sysrq-trigger

and post dmesg. Ideally to linux-kernel. 

Problem is likely unrelated to the thermal trip.

-Andi
