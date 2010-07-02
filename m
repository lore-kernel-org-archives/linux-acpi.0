From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: [PATCH 3/5]acpi:glue.c Fix warning: variable 'ret' set but not
 used
Date: Thu, 01 Jul 2010 17:59:09 -0700
Message-ID: <4C2D39DD.6010305@gmail.com>
References: <4C2CF400.20507@gmail.com> <4C2B9F49.8090304@gmail.com> <4C2A6B6C.1000306@gmail.com> <4C29674C.9070503@gmail.com> <4C28E14D.5050701@gmail.com> <1277621246-10960-4-git-send-email-justinmattock@gmail.com> <1277621246-10960-1-git-send-email-justinmattock@gmail.com> <7214.1277729293@redhat.com> <8066.1277750854@redhat.com> <22319.1277826461@redhat.com> <25800.1277889215@redhat.com> <16513.1277976706@redhat.com> <19422.1278029445@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <19422.1278029445@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

On 07/01/2010 05:10 PM, David Howells wrote:
> Justin P. Mattock<justinmattock@gmail.com>  wrote:
>
>> a bit confused with the whole:  "?:" though
>> *condition ? value if true : value if false* (what if both are true
>> what if both are false or does it matter?)
>
> If you say:
>
> 	cond ?: false_value
>
> then you'll get cond if cond is non-zero and false_value if it isn't.
>
> I suspect it's a gccism.
>
> David
>

I'll have to experiment with this one..
?:

Justin P. Mattock
