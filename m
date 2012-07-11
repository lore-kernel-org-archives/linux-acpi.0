From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/7 v2] fix memory leak when memory device is unbound
 from the module acpi_memhotplug
Date: Wed, 11 Jul 2012 14:55:19 -0700
Message-ID: <20120711145519.e94cd183.akpm@linux-foundation.org>
References: <4FFD2F1E.10006@cn.fujitsu.com>
	<4FFD2F76.9000508@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FFD2F76.9000508@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wen Congyang <wency@cn.fujitsu.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>, David Rientjes <rientjes@google.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Brown, Len" <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, 11 Jul 2012 15:47:02 +0800
Wen Congyang <wency@cn.fujitsu.com> wrote:

> To: lenb@kernel.org

I'm still not sure if that email address works?  I've been cc'ing
len.brown@intel.com lately as well.  

There are some pretty serious-looking bugfixes in this series.


I merged your patches into my tree to get them a bit of testing. 
Please note that I renamed them all so their titles reflect the
subsystem which they are patching.  Documentation/SubmittingPatches
section 15 goes into details on this convention.

Having done that rename, it becomes obvious that patches 1-6 are acpi
memhotplug changes, but the seventh patch is a fix against core MM
code.  I've sent that patch to Linus earlier today.
