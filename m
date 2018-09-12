From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] ACPI/PPTT: Handle architecturally unknown cache types
Date: Wed, 12 Sep 2018 11:37:35 +0100
Message-ID: <3eef4199-f99e-2d1d-0d1f-98b30cafb5bf@arm.com>
References: <1536694334-5811-1-git-send-email-jhugo@codeaurora.org>
 <f62f22a6-2dd8-f254-dbaf-b9e224099afd@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f62f22a6-2dd8-f254-dbaf-b9e224099afd@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>, Jeffrey Hugo <jhugo@codeaurora.org>, rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, vkilari@codeaurora.org
List-Id: linux-acpi@vger.kernel.org



On 11/09/18 21:16, Jeremy Linton wrote:
> Hi Jeffrey,
> 
> (+Sudeep)
> 

Thanks for looping me in.

> 
> If you look at the next line of code following this comment its going to
> update the cache type for fully populated PPTT nodes. Although with the
> suggested change its only going to activate if someone completely fills
> out the node and fails to set the valid flag on the cache type.
> 
> What I suspect is happening in the reported case is that the nodes in
> the PPTT table are missing fields we consider to be important. Since
> that data isn't being filled out anywhere else, so we leave the cache
> type alone too. This has the effect of hiding sysfs nodes with
> incomplete information.
> 
> Also, the lack of the DATA/INST fields is based on the assumption that
> the only nodes which need their type field updated are outside of the
> CPU core itself so they are pretty much guaranteed to be UNIFIED. Are
> you hitting this case?
> 

Completely agree with you.

-- 
Regards,
Sudeep
