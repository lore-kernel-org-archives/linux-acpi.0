From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 3/8] remove memory info from list before freeing it
Date: Tue, 26 Jun 2012 21:15:58 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1206262115440.24245@chino.kir.corp.google.com>
References: <4FE97DD5.6030205@cn.fujitsu.com> <4FE97ECF.2000903@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FE97ECF.2000903@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wen Congyang <wency@cn.fujitsu.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, 26 Jun 2012, Wen Congyang wrote:

> We free info, but we forget to remove it from the list. It will cause
> unexpected problem when we access the list next time.
> 
> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>

Acked-by: David Rientjes <rientjes@google.com>
