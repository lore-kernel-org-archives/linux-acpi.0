From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: 2.6.20rc5 k8/acpi regression ( 2.6.17.13 works fine ).
Date: Mon, 29 Jan 2007 17:30:28 -0500
Message-ID: <45BE7584.8040808@redhat.com>
References: <200701242346.44673.pluto@agmk.net>
	<20070124225238.GT17836@stusta.de>
	<200701242350.45276.lenb@kernel.org>
	<200701252311.46858.pluto@agmk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <cpufreq-bounces+glkc-cpufreq=m.gmane.org@lists.linux.org.uk>
In-Reply-To: <200701252311.46858.pluto@agmk.net>
List-Unsubscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@lists.linux.org.uk>
List-Help: <mailto:cpufreq-request@lists.linux.org.uk?subject=help>
List-Subscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=subscribe>
Sender: cpufreq-bounces@lists.linux.org.uk
Errors-To: cpufreq-bounces+glkc-cpufreq=m.gmane.org+glkc-cpufreq=m.gmane.org@lists.linux.org.uk
To: =?UTF-8?B?UGF3ZcWCIFNpa29yYQ==?= <pluto@agmk.net>
Cc: linux-acpi@vger.kernel.org, cpufreq@lists.linux.org.uk, Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Paweł Sikora wrote:
> On Thursday 25 of January 2007 05:50:45 Len Brown wrote:
>   
>> On Wednesday 24 January 2007 17:52, Adrian Bunk wrote:
>>     
>>> On Wed, Jan 24, 2007 at 11:46:44PM +0100, Paweł Sikora wrote:
>>>       
>>>> for 2.6.20rc5 i get an acpi related oops during x86-64 boot:
>>>> http://minus.ds14.agh.edu.pl/~pluto/2.6.20rc5-acpi-oops.jpg
>>>> disabling the "amd-k8 cool'n'quiet" option in bios helps.
>>>> moreover, it works fine for 2.6.17.13, so it looks like
>>>> a recent regression. i can provide more details if you need.
>>>>         
>>> thanks for your report.
>>>
>>> Can you narrow down a bit when it started?
>>> Is 2.6.19 OK?
>>> Is 2.6.18 OK?
>>>       
>> Is the stack trace always the same?  It doesn't make much sense to me.
>>     
>
> with debug options enabled oops looks better:
> http://minus.ds14.agh.edu.pl/~pluto/2.6.20rc5-oops-01.jpg
>
>   

In __rmqueue() (mm/page_alloc.c line 619:

static struct page *__rmqueue(struct zone *zone, unsigned int order)
{
        struct free_area * area;
        unsigned int current_order;
        struct page *page;

        for (current_order = order; current_order < MAX_ORDER;
++current_order) {
                area = zone->free_area + current_order;
                if (list_empty(&area->free_list))
                        continue;

                page = list_entry(area->free_list.next, struct page, lru);
                list_del(&page->lru);   <=====================
                rmv_page_order(page);
                area->nr_free--;

page->lru is NULL
