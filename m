From: Matthew Garrett <mjg@redhat.com>
Subject: Re: suspend / hibernate nomenclature
Date: Mon, 9 Mar 2009 13:26:33 +0000
Message-ID: <20090309132633.GB9797@srcf.ucam.org>
References: <1235992429.3858.58.camel@hughsie-work.lan> <15e53e180903080045x5874f05cv5ea836d73e3855b1@mail.gmail.com> <20090308144145.GB26233@srcf.ucam.org> <200903082156.46219.rjw@sisk.pl> <20090308230741.GA5357@dtor-d630.eng.vmware.com> <E1Lgatk-000Jyt-00.arvidjaar-mail-ru@mx5.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47527 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbZCIN0n (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Mar 2009 09:26:43 -0400
Content-Disposition: inline
In-Reply-To: <E1Lgatk-000Jyt-00.arvidjaar-mail-ru@mx5.mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, rjw@sisk.pl, hughsient@gmail.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 09, 2009 at 11:31:36AM +0300, Andrey Borzenkov wrote:

> What about systems that have clear indication of STR and STD on respective 
> keys? Should they continue to return KEY_SLEEP for STR? I think this 
> conflicts with definition above. So in the long run those should be changed to 
> return KEY_SUSPEND2RAM it seems.

Perhaps, but at present they KEY_SLEEP is probably adequate. KEY_SLEEP 
is always going to default to suspend to RAM, so really the only 
distinction between it and a dedicated suspend to RAM key is whether a 
UI element affects its behaviour or not.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
