From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH] ACPI/PPTT: Handle architecturally unknown cache types
Date: Wed, 12 Sep 2018 10:39:34 -0500
Message-ID: <f553018d-d27a-68e0-93f7-4f7a0497c68a@arm.com>
References: <1536694334-5811-1-git-send-email-jhugo@codeaurora.org>
 <f62f22a6-2dd8-f254-dbaf-b9e224099afd@arm.com>
 <e74f2208-ac0d-6c45-8ddb-5b77d6a42fef@codeaurora.org>
 <c34452c2-d1e8-19d8-45c1-b48ecf14bbd7@arm.com>
 <98e2e6fa-7256-b5ac-7d2e-42c858c6e57c@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <98e2e6fa-7256-b5ac-7d2e-42c858c6e57c@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffrey Hugo <jhugo@codeaurora.org>, rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, vkilari@codeaurora.org, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-acpi@vger.kernel.org

Hi,


On 09/12/2018 09:41 AM, Jeffrey Hugo wrote:
> The HW designers have indicated that there is no sane way to provide 
> sets/ways information to software, even on an informational basis (ie 
> not for cache maintenance, but for performance optimizations). Therefore 
> the firmware will not provide this information because it will be wrong.
> 
> So, therefore, we should still be able to tell the user that a cache 
> exists at the relevant level, and what size it is.  On the concerned 
> system, we cannot do that currently.

Ok, so set the fields to zero in firmware node, and mark them valid.

That logically says that there isn't any set/way information for the 
cache (which implies direct mapped).
