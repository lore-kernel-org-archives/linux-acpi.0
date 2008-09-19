From: Sitsofe Wheeler <sitsofe@yahoo.com>
Subject: Re: Thinkpad T60p does not recover from Suspend when docked.
Date: Fri, 19 Sep 2008 16:34:19 +0100
Message-ID: <48D3C67B.70909@yahoo.com>
References: <fa.C7YhwtyrMiD4q9ieD9AI3xtKz1U@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755171AbYISPeb@vger.kernel.org>
In-Reply-To: <fa.C7YhwtyrMiD4q9ieD9AI3xtKz1U@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
To: rankincj@yahoo.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Chris Rankin wrote:
> My user-space environment is Fedora 9, which automatically mounts the
> docking station's drive under /media when I login. However, it
> doesn't make any difference if I unmount this drive before suspending
> - the laptop fails to recover regardless.
> 
> I am running a 2.6.25.17-SMP kernel (for graphics card reasons), and

If you are using binary only graphics card drivers does the problem also 
happen without them never loaded at all?

I had a machine that would not suspend properly until some time part way 
through the 2.6.25 kernel. It might be worth reporting whether you have 
the same problem (perhaps by using a live cd) when you use a 2.6.26 or 
later kernel...
