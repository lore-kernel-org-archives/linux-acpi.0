From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH 0/2] Updated SPCR quirks for Moonshot/Mustang
Date: Sat, 05 Aug 2017 22:26:28 -0400
Message-ID: <1501986388.14060.44.camel@redhat.com>
References: <20170804214944.3910-1-graeme.gregory@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751220AbdHFC0a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 5 Aug 2017 22:26:30 -0400
In-Reply-To: <20170804214944.3910-1-graeme.gregory@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Graeme Gregory <graeme.gregory@linaro.org>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, lho@apm.com, gregkh@linuxfoundation.org, jcm@redhat.com

On Fri, 2017-08-04 at 22:49 +0100, Graeme Gregory wrote:
> A couple of patches to build on the SPCR quirks support already upstreamed.
> 
> 1 - Moonshot m400 cartridge has the same soc but ACPI tables have different
> HPe specific headers so extend quirk to understand those too.
> 
> 2 - Relevant vendors do not seem to be working on DBG2/SPCR update for
> situation where the clock is unknown. We want these machines to boot with
> console initialised from SPCR before I die of old age so use the previous
> quirk handling to also handle the clock problem as well.
> 
> Thanks
> 
> Graeme

For the series:

Tested-by: Mark Salter <msalter@redhat.com>
Reviewed-by: Mark Salter <msalter@redhat.com>

