From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 6/8] bind the memory device when the driver is being
 loaded
Date: Tue, 26 Jun 2012 21:24:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1206262123550.24245@chino.kir.corp.google.com>
References: <4FE97DD5.6030205@cn.fujitsu.com> <4FE97F34.9090209@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FE97F34.9090209@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wen Congyang <wency@cn.fujitsu.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, 26 Jun 2012, Wen Congyang wrote:

> We introduce acpi_hotmem_initialized to avoid strange add_memory fail message.
> The stranged add_memory fail message is printed in register_memory_resource().
> We have removed this message in the previous patch, so we can remove
> it(it is very useful to the next patch).
> 

I don't think you can legitimately remove that message, see my comment in 
the previous patch.  There are many callers to add_memory() and it seems 
like this workaround solves most of the pain for acpi, so maybe we can 
just live with it?
