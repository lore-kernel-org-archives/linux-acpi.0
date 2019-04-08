From: Jens Axboe <axboe@kernel.dk>
Subject: Re: Thinkpad X60: regression with 5.1-rc1 and 5.1-rc4
Date: Mon, 8 Apr 2019 11:41:18 -0600
Message-ID: <678ab058-986c-9727-58d7-d3f5283e2225@kernel.dk>
References: <20190408173914.GA13260@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190408173914.GA13260@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Cc: paolo.valente@linaro.org, linux-block@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 4/8/19 11:39 AM, Pavel Machek wrote:
> Hi!
> 
> For some reason, Thinkpad X60 now crashes during boot. I see some
> weird backtraces, and it may be bfq related... or maybe ACPI idle.
> 
> Does x86-32 work for you?
> 
> Weird thing is, 5.1.0-rc3-next-20190408 boots here (but later has
> problems during resume, making it unusable, too). They may not have
> 100% same configs. 

Can you try and revert:

9dee8b3b057e1

and see if that helps?

-- 
Jens Axboe
