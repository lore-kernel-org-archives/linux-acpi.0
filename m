From: Mattia Dongili <malattia@linux.it>
Subject: Re: acpi on sony vaio vgn-sz61mn
Date: Thu, 18 Jun 2009 11:16:51 +0900
Message-ID: <20090618021651.GB12221@kamineko.org>
References: <4A38F2FA.5000207@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:38071
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753953AbZFRCQu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Jun 2009 22:16:50 -0400
Content-Disposition: inline
In-Reply-To: <4A38F2FA.5000207@uni-koblenz.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sebastian Pohl <sebastianp@uni-koblenz.de>
Cc: linux-acpi@vger.kernel.org

On Wed, Jun 17, 2009 at 03:43:22PM +0200, Sebastian Pohl wrote:
> Hello everyone!
>
> Thank you to everyone working on the sony stuff! It made my laptop a  
> much more valuable companion!
>
> But there are still some flaws that are left. I am writing to get an  
> advise what to do with them. Should i post them to bugtrackter or  
> something else?
>
> Ok, the problems are:
>
> - The special button s2 generates the same acpi event as the stamina switch

yep, I have some ideas how to fix it in sony-laptop, I'll try to get it
done this weekend.

> - The lidswitch does not generate any acpi events
> - The Power does not generate any acpi events

these should be part of the main acpi code, please follow Zhang
directions to debug this.

Thanks
-- 
mattia
:wq!
